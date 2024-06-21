import os
import torch
import torch.nn as nn
import seqpro as sp
from eugene.dataload._augment import RandomRC
from bpnetlite.bpnet import BPNet
from bpnetlite.losses import MNLLLoss, log1pMSELoss
from bpnetlite.performance import calculate_performance_measures


# Just crop the inputs to the model since there is no jittering
def crop(x, trimming=0, max_jitter=0):
    return torch.as_tensor(x[..., max_jitter+trimming:-max_jitter-trimming].astype('f4'))


# Current random rc implementation requires tensors
def to_tensor(x):
    return tuple(torch.as_tensor(arr, dtype=torch.float32) for arr in x)


def get_transforms(jitter=True, rc=True, trimming=0, max_jitter=0, rc_prob=0):
    """Ensure that order of the transforms is in the order they are placed in the dictionary."""
    transforms = {}
    if jitter:
        transforms[('ohe_seq', 'cov')] = lambda x: sp.jitter(*x, max_jitter=max_jitter, length_axis=-1, jitter_axes=0)
        transforms['cov'] = lambda x: crop(x, trimming=trimming)  # jitter already happened
    else:
        transforms['ohe_seq'] = lambda x: crop(x, max_jitter=max_jitter)
        transforms['cov'] = lambda x: crop(x, max_jitter=max_jitter, trimming=trimming)
    if rc:
        transforms[('cov', 'ohe_seq')] = lambda x: RandomRC(rc_prob=rc_prob)(*tuple(torch.as_tensor(arr, dtype=torch.float32) for arr in x))
    
    return transforms


def bpnetlite_loss(outputs_dict, targets_dict, alpha=1):
    y_profile = outputs_dict['profile']
    y_counts = outputs_dict['counts'].reshape(-1, 1)
    y = targets_dict['cov']
    y_profile = y_profile.reshape(y_profile.shape[0], -1)
    y_profile = torch.nn.functional.log_softmax(y_profile, dim=-1)
    y = y.reshape(y.shape[0], -1)
    profile_loss = MNLLLoss(y_profile, y)
    count_loss = log1pMSELoss(y_counts, y.sum(dim=-1).reshape(-1, 1))
    loss = profile_loss + alpha * count_loss
    return{
        "loss": loss,
        "profile_loss": profile_loss,
        "count_loss": count_loss,
    }


def bpnetlite_metrics(outputs_dict, targets_dict, alpha=1):=
    y_profile = outputs_dict['profile']
    y_counts = outputs_dict['counts']
    y = targets_dict['cov']

    z = y_profile.shape
    y_profile = y_profile.reshape(y_profile.shape[0], -1)
    y_profile = torch.nn.functional.log_softmax(y_profile, dim=-1)
    y_profile = y_profile.reshape(*z)
    measures = calculate_performance_measures(
        y_profile, 
        y, 
        y_counts, 
        kernel_sigma=7, 
        kernel_width=81, 
        measures=['profile_mnll', 'profile_pearson', 'count_mse', 'count_pearson']
    )
    profile_mnll = measures['profile_mnll'].cpu()
    count_mse  = measures['count_mse'].cpu()
    profile_corr = measures['profile_pearson'].cpu()
    count_corr = measures['count_pearson'].cpu()
    loss = measures['profile_mnll'].cpu() + alpha * measures['count_mse'].cpu()
    return{
        "profile_mnll": profile_mnll,
        "count_mse": count_mse,
        "profile_corr": profile_corr,
        "count_corr": count_corr,
        "loss": loss,
    }

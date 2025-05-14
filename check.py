from mmdet3d.apis import inference_multi_modality_detector, init_model
import numpy as np
import torch

config_path = r"C:\Users\d_sin\VSCode Projects\Dockerprobe\bevdet-r50.py"
weights_path = r"C:\Users\d_sin\VSCode Projects\Dockerprobe\epoch_1.pth"
model = init_model(config_path, weights_path, device='cuda' if torch.cuda.is_available() else 'cpu')

print(model)

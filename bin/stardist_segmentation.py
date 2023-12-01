import os
import numpy as np
import tifffile as tiff
from stardist import random_label_cmap, _draw_polygons, export_imagej_rois
from csbdeep.utils import Path, normalize
lbl_cmap = random_label_cmap()
from stardist.models import StarDist2D
from skimage import segmentation
import fire
# prints a list of available models
#StarDist2D.from_pretrained()
# creates a pretrained model
model = StarDist2D.from_pretrained('2D_versatile_fluo')

def segment4baysor(
        img_path: str,
        outdir: str
    ):
    img = tiff.memmap(img_path)
    img = normalize(img, 1, 99.8, axis=(0,1))
    labels, details = model.predict_instances(img)
    labels_baysor = labels.astype(np.uint8)
    # Find boundaries:
    edges = segmentation.find_boundaries(labels_baysor, mode="inner")
    # Now substract boundaries to labeled mask:
    binary = labels_baysor > 0
    edges_binary = edges > 0

    binary[edges_binary] = 0
    tiff.imwrite(os.path.join(outdir, 'mask4baysor.tif'), binary.astype(np.uint8))

if __name__ == '__main__':
    cli = {
        "run": segment4baysor
    }
    fire.Fire(cli)
#!/usr/bin/env python3

import pandas as pd
import napari
import numpy as np
import random
import argparse
import json

def rep(data):
    return np.reshape(np.array(data), (len(data), 1))

def load_polygons(polygons):
        # Polygon loading part:
    with open(polygons, 'r') as fh:
        data = json.load(fh)
    cells = []
    for i, cell in enumerate(data['geometries'][:]):
        polygon_array = np.array(cell['coordinates'][0])
        cells.append(np.flip(polygon_array, axis=1))
        #cells.append(np.array([cell['coordinates'][0][:,1], cell['coordinates'][0][:,0]]))
    return cells

def main(
        input_spots, 
        size_spots,
        polygons
    ):
    # Spot loading part:
    RESULTDIR = input_spots

    df = pd.read_csv(RESULTDIR)
    df = df[~df['is_noise']]

    dots = np.concatenate((rep(df.y), rep(df.x)), axis=1)
    colors = {}

    for i in df.cluster.unique():
        colors[i] = '#%06X' % random.randint(0, 0xFFFFFF)
    
    color_array = [colors[i] for i in df.cluster.loc[:]]
    properties = {'cluster': list(df.cluster)}
    
    # polygons loading:
    cells = load_polygons(polygons)
    
    viewer = napari.Viewer()
    viewer.add_points(dots, size=size_spots, face_color=color_array, properties=properties)
    viewer.add_shapes(cells, shape_type='polygon')
    napari.run()

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-i', '--input_clusters', type=str, default='/hdd_scratch3/nk854004/ISS_303_nucl_pos_with_cluster.csv')
    parser.add_argument('-s', '--size_points', type=int, default=15)
    parser.add_argument('-p', '--polygons', type=str, help='GEOJSON file with polygon coordinates from segmentation')
    
    args = parser.parse_args()
    main(args.input_clusters, args.size_points, args.polygons)


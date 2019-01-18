import { reactWidget } from 'reactR';
import React from 'react';
import ReactMapboxGl, { Layer, Feature } from "react-mapbox-gl";

reactWidget('MapboxGL', 'output', {
    Map: ({ accessToken, children, ...props }) => {
        const _Map = ReactMapboxGl({ accessToken: accessToken });
        return React.createElement(_Map, props, children)
    },
    Layer: Layer,
    Feature: Feature
}, {});
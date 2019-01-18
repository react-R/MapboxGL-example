var path = require('path');

module.exports = {
    entry: path.join(__dirname, 'srcjs', 'MapboxGL.js'),
    output: {
        path: path.join(__dirname, 'inst', 'htmlwidgets'),
        filename: 'MapboxGL.js'
    },
    module: {
        rules: [
            {
                test: /\.css$/,
                use: ['style-loader', 'css-loader'],
            },
            {
                test: /\.js$/,
                loader: 'babel-loader',
                options: {
                    presets: ['@babel/preset-env', '@babel/preset-react']
                },
                exclude: /(node_modules)/
            }
        ]
    },
    externals: {
        'react': 'window.React',
        'react-dom': 'window.ReactDOM',
        'reactR': 'window.reactR'
    },
    stats: {
        colors: true
    },
    devtool: 'source-map',
    resolve: {
        alias: {
            'mapbox-gl$': path.resolve('./node_modules/mapbox-gl/dist/mapbox-gl.js')
        }
    }
};
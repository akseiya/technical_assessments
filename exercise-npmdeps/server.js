'use strict';

const Hapi = require('hapi');

// Create a server with a host and port
const server = Hapi.server({
    host:'localhost',
    port:8000
});

// Start the server
async function start() {
    await server.register(require('inert'));

    server.route({
        method: 'GET',
        path: '/',
        handler: (request, h) => {

            return h.file('./public/index.html');
        },
    });


    try {
        await server.start();
    }
    catch (err) {
        console.log(err);
        process.exit(1);
    }

    console.log('Server running at:', server.info.uri);
};

start();
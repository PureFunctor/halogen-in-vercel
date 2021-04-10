const Server = require("./output/Server/");
const app = require("express")();
Server.attach(app)();
module.exports = app;

const express = require('express');
const router = express.Router();

const {JsonDB, Config} = require('node-json-db');
const userDb = new JsonDB(new Config('./db/users.json', true, false, '/'));

router.post('/', (req, res) => {
    const {username, password} = req.body;

    if (!!username && !!password) {
        userDb
            .getData(`/${username}`)
            .then((userData) => {
                console.info('Found user data for: ', userData);

                const usernamesMatch = username === userData.username;
                const passwordsMatch = password === userData.password;

                const authorized = usernamesMatch && passwordsMatch;

                if (authorized) {
                    res.send({message: 'success'});
                } else {
                    res.sendStatus(403);
                }
            })
            .catch((err) => {
                console.log('error:', err);
                res.sendStatus(400);
            });
    } else {
        res.sendStatus(400);
    }
});

module.exports = router;

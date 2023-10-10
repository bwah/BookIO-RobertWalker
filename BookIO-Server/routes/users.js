const express = require('express');
const router = express.Router();

const {JsonDB, Config} = require('node-json-db');
const userDb = new JsonDB(new Config('./db/users.json', true, false, '/'));

router.post('/new', (req, res) => {
    const {username, password} = req.body;

    if (!!username && !!password) {
        userDb
            .push(`/${username}`, {username, password})
            .then(() => {
                res.status(201).send({message: 'success'});
            })
            .catch(() => {
                res.sendStatus(500);
            });
    } else {
        res.sendStatus(400);
    }
});

router
    .route('/:username/favorites')
    .post((req, res) => {
        const username = req.params.username;
        const favoriteBookId = req.body.book;

        userDb
            .getData(`/${username}`)
            .then((userData) => {
                console.info('Found user data for: ', userData);

                userDb.push(
                    `/${username}`,
                    {favorites: {book: favoriteBookId}},
                    false
                );
            })
            .then(() => {
                res.send({message: 'success'});
            })
            .catch((err) => {
                console.log('error:', err);
                res.sendStatus(400);
            });
    })
    .get((req, res) => {
        const username = req.params.username;

        userDb
            .getData(`/${username}`)
            .then((userData) => {
                console.info('Found user data for: ', userData);

                const {favorites} = userData;
                const payload = {data: {favorites}};

                res.send(payload);
            })
            .catch((err) => {
                console.log('error:', err);
                res.sendStatus(500);
            });
    });

module.exports = router;

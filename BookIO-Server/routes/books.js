const express = require('express');
const router = express.Router();

const jsonBooks = require('../db/books.json');

router.get('/', (req, res) => {
    const payload = {data: jsonBooks};

    res.json(payload);
});

module.exports = router;

const express = require('express');
const cors = require('cors');

const userRouter = require('./routes/users');
const booksRouter = require('./routes/books');
const loginRouter = require('./routes/login');

const app = express();
app.use(cors({origin: '*'}));
app.use(express.urlencoded({extended: true}));
app.use(express.json());
app.listen(9000);

app.get('/', (req, res) => {
    res.json({message: 'Oh you made it!'});
});

app.use('/users', userRouter);
app.use('/books', booksRouter);
app.use('/login', loginRouter);

const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { APP_SECRET, getUserId } = require('../utils');

async function signup(_, args, context, info) {
  const password = await bcrypt.hash(args.password, 10);
  const user = await context.db.mutation.createUser(
    {
      data: { ...args, password },
    },
    `{ id }`
  );
  const token = jwt.sign({ userId: user.id }, APP_SECRET);

  return {
    token,
    user,
  };
}

async function login(_, args, context, info) {
  const user = await context.db.query.user(
    { where: { email: args.email } },
    `{ id password }`
  );

  if (!user) {
    throw new Error('No such user found');
  }

  const valid = await bcrypt.compare(args.password, user.password);

  if (!valid) {
    throw new Error('Invalid Password');
  }

  const token = jwt.sign({ userId: user.id }, APP_SECRET);

  return {
    token,
    user,
  };
}

function createGame(_, { name, description, slug }, context, info) {
  const userId = getUserId(context);
  return context.db.mutation.createGame({
    data: {
      name,
      description,
      slug,
    },
  });
}

function createExercise(_, { gameId }, context, info) {
  const userId = getUserId(context);
  return context.db.mutation.createGame(
    {
      data: {
        owner: { connect: { id: userId } },
        game: { connect: { id: gameId } },
      },
    },
    info
  );
}

function createWord(_, args, context, info) {
  const userId = getUserId(context);
  return context.db.mutation.createWord(
    {
      data: args,
    },
    info
  );
}

module.exports = {
  signup,
  login,
  createGame,
  createExercise,
  createWord,
};

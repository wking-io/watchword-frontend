const { GraphQLServer } = require('graphql-yoga');
const { Prisma } = require('prisma-binding');
const Query = require('./resolvers/Query');
const Mutation = require('./resolvers/Mutation');
const AuthPayload = require('./resolvers/AuthPayload');

const resolvers = {
  Query,
  Mutation,
  AuthPayload,
};

const server = new GraphQLServer({
  typeDefs: 'src/backend/schema.graphql',
  resolvers,
  resolverValidationOptions: {
    requireResolversForResolveType: false,
  },
  context: req => ({
    ...req,
    db: new Prisma({
      typeDefs: 'src/backend/generated/prisma.graphql',
      endpoint: 'https://us1.prisma.sh/william-king-4b9a55/school-app/dev',
    }),
  }),
});

server.start(() => console.log(`Server is running on http://localhost:4000`));

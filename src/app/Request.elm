module Request exposing (query, mutation)

import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery, RootMutation)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Task exposing (Task)
import Data.AuthToken exposing (AuthToken, withAuthorization)


query : Maybe AuthToken -> SelectionSet decodesTo RootQuery -> Task (Graphqelm.Http.Error decodesTo) decodesTo
query token query =
    query
        |> Graphqelm.Http.queryRequest "http://localhost:8000/graphql"
        |> withAuthorization token
        |> Graphqelm.Http.toTask


mutation : Maybe AuthToken -> SelectionSet decodesTo RootMutation -> Task (Graphqelm.Http.Error decodesTo) decodesTo
mutation token query =
    query
        |> Graphqelm.Http.mutationRequest "http://localhost:8000/graphql"
        |> withAuthorization token
        |> Graphqelm.Http.toTask

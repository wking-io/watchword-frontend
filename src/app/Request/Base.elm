module Request.Base exposing (makeRequest)

import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Task exposing (Task)
import Data.AuthToken exposing (AuthToken, withAuthorization)


makeRequest : Maybe AuthToken -> SelectionSet decodesTo RootQuery -> Task (Graphqelm.Http.Error decodesTo) decodesTo
makeRequest token query =
    query
        |> Graphqelm.Http.queryRequest "https://watchword-api.now.sh"
        |> withAuthorization token
        |> Graphqelm.Http.toTask

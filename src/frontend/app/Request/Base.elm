module Request.Base exposing (makeRequest)

import Graphqelm.Http
import Graphqelm.Operation exposing (RootQuery)
import Graphqelm.SelectionSet exposing (SelectionSet)
import Task exposing (Task)


makeRequest : SelectionSet decodesTo RootQuery -> Task (Graphqelm.Http.Error decodesTo) decodesTo
makeRequest query =
    query
        |> Graphqelm.Http.queryRequest "https://us1.prisma.sh/william-king-4b9a55/school-app/dev"
        |> Graphqelm.Http.withHeader "authorization" "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiJjamhmMHY3NndjZHIxMGI2MnVrcHJmbHk4IiwiaWF0IjoxNTI2ODMyODY1fQ.jxSX5mtTnhkdYhttttcYoN0PdkOiYsEE-WWTMkiNkNo"
        |> Graphqelm.Http.toTask

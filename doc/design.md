# Design document

This document describes key technologies and architecture.

## Requirements

###  Operations

#### Registration

1. Anyone can register as a volunteer just by providing a unique ID and a
   password where neither can be empty.
2. No person verification mechanism is involved (not even anti-robot barrier).
3. Just make sure entered values fit in requirements.

#### Log in

1. A volunteer can log in by providing her/his ID and password.
2. For sake of simplicity, we assume the server runs only with HTTPS and HTTP
   Basic authentication will be used.
3. Successful log in creates a new session.
4. Session expires after predefined time of no activity.
5. There is a special service for authorizations which returns a token

#### Volunteer details

1. A authenticated volunteer can display list of teams she/he belongs to.
2. A authenticated volunteer cannot display list of teams of any other volunteer.

#### Team create

1. An authenticated volunteer can create a new team by providing a new unique ID
   and name where neither can be empty.

#### Team details

1. An authenticated volunteer can display list of teams she/he belongs to.
2. An authenticated volunteer cannot display list of teams of any other volunteer.

#### Team assign

1. An authenticated volunteer can join a team if not yet done.

### Data

#### Volunteer

- Persistent

1. Volunteer has a unique ID
 - string of 16 characters
 - no white space allowed

2. Volunteer has a password
 - stored as HASH
 - string of 32 characters

#### Team of volunteers

- Persistent

1. Team has a unique ID
 - string of 16 characters
 - no white space allowed

2. Team has a nick name
 - string of 16 characters

#### Membership

- Persistent

1. A team's ID
2. A volunteer's ID

#### Session

- Persistent to enable concurrent servers

1. Token
2. Volunteer ID
3. Last activity

### Tools

#### Team statistics

1. Writes the number of users in every team to a regular text file.
2. Uses GraphQL queries

## Architecture

```
             +----------+
             |          |
             | database |
             |          |
             +----------+
                  ^
                  |
             +----------+
             |          |
             | database |
             |    to    |
     +------>| grapql   |<------+
     |       |  adapter |       |
     |       +----------+       |
     |             ^            |
     |             |            |
 +------+   +---------+    +---------+
 |      |   |         |    |         |
 | auth |<--| service |    | statics |
 |      |   |         |    |         |
 +------+   +---------+    +---------+
```

## Technologies
- [Go](https://golang.org/)
- [net/http](https://golang.org/pkg/net/http/)
- [GraphQL](https://github.com/graphql-go/graphql)
- [SQLite](https://github.com/mattn/go-sqlite3)


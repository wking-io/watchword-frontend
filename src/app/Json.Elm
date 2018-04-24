module Json exposing (games, words)


games : String
games =
    """
      {
        "data": [
          {
            "id": "memory",
            "name": "Match & Memory",
            "description": "Match & Memory is a game that helps students practice their word groups. Students will match words based on their word endings by wordentifying the contents of flipped cards. When a pair is matched the cards stay flipped until all matches have been made.",
            "skills": [
              "Word Endings",
              "Memory",
              "Word Sounds",
              "Letter wordentification"
            ]
          }
        ]
      }
    """


words : String
words =
    """
      {
        "data": [
          {
            "word": "run",
            "group": "un",
            "beginning": "r",
            "ending": "n",
            "vowel": "u"
          },
          {
            "word": "bun",
            "group": "un",
            "beginning": "r",
            "ending": "n",
            "vowel": "u"
          },
          {
            "word": "sun",
            "group": "un",
            "beginning": "r",
            "ending": "n",
            "vowel": "u"
          },
          {
            "word": "fun",
            "group": "un",
            "beginning": "r",
            "ending": "n",
            "vowel": "u"
          },
          {
            "word": "nun",
            "group": "un",
            "beginning": "r",
            "ending": "n",
            "vowel": "u"
          },
          {
            "word": "bat",
            "group": "at",
            "beginning": "b",
            "ending": "t",
            "vowel": "a"
          },
          {
            "word": "cat",
            "group": "at",
            "beginning": "c",
            "ending": "t",
            "vowel": "a"
          },
          {
            "word": "hat",
            "group": "at",
            "beginning": "h",
            "ending": "t",
            "vowel": "a"
          },
          {
            "word": "mat",
            "group": "at",
            "beginning": "m",
            "ending": "t",
            "vowel": "a"
          },
          {
            "word": "rat",
            "group": "at",
            "beginning": "r",
            "ending": "t",
            "vowel": "a"
          },
          {
            "word": "chat",
            "group": "at",
            "beginning": "ch",
            "ending": "t",
            "vowel": "a"
          }
        ]
      }
    """

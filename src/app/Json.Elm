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
            ],
            "option": {
              "type": "radio-horizontal",
              "choices": [
                {
                  "value": "random",
                  "label": "Random Selection",
                  "description": "A game where words are selected randomly from the chosen word groups. Also, matches in the game must be the same word."
                },
                {
                  "value": "custom",
                  "label": "You Pick Selection",
                  "description": "A game where you get to choose the words that are used. Also, matches in the game must be the same word."
                }
              ]
            },
            "size": {
              "type": "radio-vertical",
              "choices": [
                {
                  "value": "small",
                  "label": "Small - 3 Words",
                  "description": "Total words to match will be three so there will be six cards on the board."
                },
                {
                  "value": "medium",
                  "label": "Medium - 4 Words",
                  "description": "Total words to match will be four so there will be eight cards on the board."
                },
                {
                  "value": "large",
                  "label": "Large - 5 Words",
                  "description": "Total words to match will be five so there will be ten cards on the board."
                },
                {
                  "value": "xtralarge",
                  "label": "ExtraLarge - 6 Words",
                  "description": "Total words to match will be six so there will be twelve cards on the board."
                }
              ]
            },
          },
          {
            "id": "memory-01",
            "name": "Match & Memory 01",
            "description": "Match & Memory is a game that helps students practice their word groups. Students will match words based on their word endings by wordentifying the contents of flipped cards. When a pair is matched the cards stay flipped until all matches have been made.",
            "skills": [
              "Word Endings",
              "Memory",
              "Word Sounds",
              "Letter wordentification"
            ],
            "option": {
              "type": "radio-horizontal",
              "choices": [
                {
                  "value": "random",
                  "label": "Random Selection",
                  "description": "A game where words are selected randomly from the chosen word groups. Also, matches in the game must be the same word."
                },
                {
                  "value": "custom",
                  "label": "You Pick Selection",
                  "description": "A game where you get to choose the words that are used. Also, matches in the game must be the same word."
                }
              ]
            },
            "size": {
              "type": "radio-vertical",
              "choices": [
                {
                  "value": "small",
                  "label": "Small - 3 Words",
                  "description": "Total words to match will be three so there will be six cards on the board."
                },
                {
                  "value": "medium",
                  "label": "Medium - 4 Words",
                  "description": "Total words to match will be four so there will be eight cards on the board."
                },
                {
                  "value": "large",
                  "label": "Large - 5 Words",
                  "description": "Total words to match will be five so there will be ten cards on the board."
                },
                {
                  "value": "xtralarge",
                  "label": "ExtraLarge - 6 Words",
                  "description": "Total words to match will be six so there will be twelve cards on the board."
                }
              ]
            }
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

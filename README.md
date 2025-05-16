# Delete vs New array gas efficiency

## Run tests

```sh
forge test
```

## Tests results with uint8[]

- 0.8.30 OK
- 0.8.29 OK
- 0.8.28 OK
- 0.8.27 OK
- 0.8.26 KO: 1138 != 1137, 986 != 985 (testUseDeleteKeyword\* fail)
- 0.8.25 KO: 1138 != 1137, 986 != 985 (testUseDeleteKeyword\* fail)
- 0.8.24 KO: 1138 != 1137, 986 != 985 (testUseDeleteKeyword\* fail)

`delete x;` cost less gas than `x = new type[](0);`.

|                 | reset empty array gas used | reset non empty array gas used |
| --------------- | -------------------------- | ------------------------------ |
| `delete`        | 985                        | 1137                           |
| `new type[](0)` | 1210                       | 1362                           |

`1137 - 985 = 152` gas saved with empty arrays using `delete`.
`1362 - 1210 = 152` gas saved with non empty arrays using `delete`.

## Tests results with uint256[]

- 0.8.30 OK
- 0.8.29 OK
- 0.8.28 OK
- 0.8.27 OK
- 0.8.26 KO: 969 != 968, 1121 != 1120, 1276 != 1275, 1431 != 1430 (testUseDeleteKeyword\* fail)
- 0.8.25 KO: 969 != 968, 1121 != 1120, 1276 != 1275, 1431 != 1430 (testUseDeleteKeyword\* fail)
- 0.8.24 KO: 969 != 968, 1121 != 1120, 1276 != 1275, 1431 != 1430 (testUseDeleteKeyword\* fail)

`delete x;` cost less gas than `x = new type[](0);`.

|                 | len 0 | len 1 | len 2 | len 3 |
| --------------- | ----- | ----- | ----- | ----- |
| `delete`        | 968   | 1120  | 1275  | 1430  |
| `new type[](0)` | 1193  | 1345  | 1500  | 1655  |

`1430 - 1275 = 155` gas used to remove an element with `delete`.
`1655 - 1500 = 155` gas used to remove an element with `new type[](0)`.

`1193 - 968 = 225` gas saved with empty arrays using `delete`.
`1655 - 1430 = 225` gas saved with len 3 arrays using `delete`.

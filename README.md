# Delete vs New array gas efficiency

## Run tests

```sh
forge test
```

## Tests results

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

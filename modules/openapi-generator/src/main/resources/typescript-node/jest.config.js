module.exports = {
    roots: [
        "<rootDir>/test"
    ],
    testTimeout: 20000,
    testRegex: 'test/(.+)\\.test\\.(jsx?|tsx?)$',
    transform: {
        "^.+\\.tsx?$": "ts-jest"
    },
    testEnvironment: "node",
    moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
};
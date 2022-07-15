# coding: utf-8

"""
    openapi 3.0.3 sample spec

    sample spec for testing openapi functionality, built from json schema tests for draft6  # noqa: E501

    The version of the OpenAPI document: 0.0.1
    Generated by: https://openapi-generator.tech
"""

import unittest

import unit_test_api
from unit_test_api.model.minlength_validation import MinlengthValidation
from unit_test_api import configuration


class TestMinlengthValidation(unittest.TestCase):
    """MinlengthValidation unit test stubs"""
    _configuration = configuration.Configuration()

    def test_too_short_is_invalid_fails(self):
        # too short is invalid
        with self.assertRaises((unit_test_api.ApiValueError, unit_test_api.ApiTypeError)):
            MinlengthValidation._from_openapi_data(
                "f",
                _configuration=self._configuration
            )

    def test_one_supplementary_unicode_code_point_is_not_long_enough_fails(self):
        # one supplementary Unicode code point is not long enough
        with self.assertRaises((unit_test_api.ApiValueError, unit_test_api.ApiTypeError)):
            MinlengthValidation._from_openapi_data(
                "💩",
                _configuration=self._configuration
            )

    def test_longer_is_valid_passes(self):
        # longer is valid
        MinlengthValidation._from_openapi_data(
            "foo",
            _configuration=self._configuration
        )

    def test_ignores_non_strings_passes(self):
        # ignores non-strings
        MinlengthValidation._from_openapi_data(
            1,
            _configuration=self._configuration
        )

    def test_exact_length_is_valid_passes(self):
        # exact length is valid
        MinlengthValidation._from_openapi_data(
            "fo",
            _configuration=self._configuration
        )


if __name__ == '__main__':
    unittest.main()

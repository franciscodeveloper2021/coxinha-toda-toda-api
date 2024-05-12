# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `jwt` gem.
# Please instead update this file by running `bin/tapioca gem jwt`.


# JSON Web Token implementation
#
# Should be up to date with the latest spec:
# https://tools.ietf.org/html/rfc7519
#
# source://jwt//lib/jwt/version.rb#4
module JWT
  extend ::JWT::Configuration

  private

  # source://jwt//lib/jwt.rb#29
  def decode(jwt, key = T.unsafe(nil), verify = T.unsafe(nil), options = T.unsafe(nil), &keyfinder); end

  # source://jwt//lib/jwt.rb#22
  def encode(payload, key, algorithm = T.unsafe(nil), header_fields = T.unsafe(nil)); end

  class << self
    # source://jwt//lib/jwt.rb#29
    def decode(jwt, key = T.unsafe(nil), verify = T.unsafe(nil), options = T.unsafe(nil), &keyfinder); end

    # source://jwt//lib/jwt.rb#22
    def encode(payload, key, algorithm = T.unsafe(nil), header_fields = T.unsafe(nil)); end

    # source://jwt//lib/jwt/version.rb#5
    def gem_version; end

    # @return [Boolean]
    #
    # source://jwt//lib/jwt/version.rb#24
    def openssl_3?; end

    # @return [Boolean]
    #
    # source://jwt//lib/jwt/version.rb#38
    def openssl_3_hmac_empty_key_regression?; end

    # source://jwt//lib/jwt/version.rb#42
    def openssl_version; end

    # @return [Boolean]
    #
    # source://jwt//lib/jwt/version.rb#30
    def rbnacl?; end

    # @return [Boolean]
    #
    # source://jwt//lib/jwt/version.rb#34
    def rbnacl_6_or_greater?; end
  end
end

# Base64 encoding and decoding
#
# source://jwt//lib/jwt/base64.rb#7
class JWT::Base64
  class << self
    # source://jwt//lib/jwt/base64.rb#27
    def loose_urlsafe_decode64(str); end

    # Decode a string with URL-safe Base64 complying with RFC 4648.
    # Deprecated support for RFC 2045 remains for now. ("All line breaks or other characters not found in Table 1 must be ignored by decoding software")
    #
    # source://jwt//lib/jwt/base64.rb#16
    def url_decode(str); end

    # Encode a string with URL-safe Base64 complying with RFC 4648 (not padded).
    #
    # source://jwt//lib/jwt/base64.rb#10
    def url_encode(str); end
  end
end

# source://jwt//lib/jwt/error.rb#20
class JWT::Base64DecodeError < ::JWT::DecodeError; end

# source://jwt//lib/jwt/claims_validator.rb#6
class JWT::ClaimsValidator
  # @return [ClaimsValidator] a new instance of ClaimsValidator
  #
  # source://jwt//lib/jwt/claims_validator.rb#13
  def initialize(payload); end

  # source://jwt//lib/jwt/claims_validator.rb#17
  def validate!; end

  private

  # @raise [InvalidPayload]
  #
  # source://jwt//lib/jwt/claims_validator.rb#31
  def validate_is_numeric(claim); end

  # source://jwt//lib/jwt/claims_validator.rb#25
  def validate_numeric_claims; end
end

# source://jwt//lib/jwt/claims_validator.rb#7
JWT::ClaimsValidator::NUMERIC_CLAIMS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/configuration/decode_configuration.rb#4
module JWT::Configuration
  # source://jwt//lib/jwt/configuration.rb#11
  def configuration; end

  # @yield [configuration]
  #
  # source://jwt//lib/jwt/configuration.rb#7
  def configure; end
end

# source://jwt//lib/jwt/configuration/container.rb#8
class JWT::Configuration::Container
  # @return [Container] a new instance of Container
  #
  # source://jwt//lib/jwt/configuration/container.rb#12
  def initialize; end

  # Returns the value of attribute decode.
  #
  # source://jwt//lib/jwt/configuration/container.rb#9
  def decode; end

  # Sets the attribute decode
  #
  # @param value the value to set the attribute decode to.
  #
  # source://jwt//lib/jwt/configuration/container.rb#9
  def decode=(_arg0); end

  # Returns the value of attribute deprecation_warnings.
  #
  # source://jwt//lib/jwt/configuration/container.rb#10
  def deprecation_warnings; end

  # @raise [ArgumentError]
  #
  # source://jwt//lib/jwt/configuration/container.rb#25
  def deprecation_warnings=(value); end

  # Returns the value of attribute jwk.
  #
  # source://jwt//lib/jwt/configuration/container.rb#9
  def jwk; end

  # Sets the attribute jwk
  #
  # @param value the value to set the attribute jwk to.
  #
  # source://jwt//lib/jwt/configuration/container.rb#9
  def jwk=(_arg0); end

  # source://jwt//lib/jwt/configuration/container.rb#16
  def reset!; end

  # Returns the value of attribute strict_base64_decoding.
  #
  # source://jwt//lib/jwt/configuration/container.rb#9
  def strict_base64_decoding; end

  # Sets the attribute strict_base64_decoding
  #
  # @param value the value to set the attribute strict_base64_decoding to.
  #
  # source://jwt//lib/jwt/configuration/container.rb#9
  def strict_base64_decoding=(_arg0); end
end

# source://jwt//lib/jwt/configuration/container.rb#24
JWT::Configuration::Container::DEPRECATION_WARNINGS_VALUES = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/configuration/decode_configuration.rb#5
class JWT::Configuration::DecodeConfiguration
  # @return [DecodeConfiguration] a new instance of DecodeConfiguration
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#17
  def initialize; end

  # Returns the value of attribute algorithms.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def algorithms; end

  # Sets the attribute algorithms
  #
  # @param value the value to set the attribute algorithms to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def algorithms=(_arg0); end

  # Returns the value of attribute leeway.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def leeway; end

  # Sets the attribute leeway
  #
  # @param value the value to set the attribute leeway to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def leeway=(_arg0); end

  # Returns the value of attribute required_claims.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def required_claims; end

  # Sets the attribute required_claims
  #
  # @param value the value to set the attribute required_claims to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def required_claims=(_arg0); end

  # source://jwt//lib/jwt/configuration/decode_configuration.rb#30
  def to_h; end

  # Returns the value of attribute verify_aud.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_aud; end

  # Sets the attribute verify_aud
  #
  # @param value the value to set the attribute verify_aud to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_aud=(_arg0); end

  # Returns the value of attribute verify_expiration.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_expiration; end

  # Sets the attribute verify_expiration
  #
  # @param value the value to set the attribute verify_expiration to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_expiration=(_arg0); end

  # Returns the value of attribute verify_iat.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_iat; end

  # Sets the attribute verify_iat
  #
  # @param value the value to set the attribute verify_iat to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_iat=(_arg0); end

  # Returns the value of attribute verify_iss.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_iss; end

  # Sets the attribute verify_iss
  #
  # @param value the value to set the attribute verify_iss to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_iss=(_arg0); end

  # Returns the value of attribute verify_jti.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_jti; end

  # Sets the attribute verify_jti
  #
  # @param value the value to set the attribute verify_jti to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_jti=(_arg0); end

  # Returns the value of attribute verify_not_before.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_not_before; end

  # Sets the attribute verify_not_before
  #
  # @param value the value to set the attribute verify_not_before to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_not_before=(_arg0); end

  # Returns the value of attribute verify_sub.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_sub; end

  # Sets the attribute verify_sub
  #
  # @param value the value to set the attribute verify_sub to.
  #
  # source://jwt//lib/jwt/configuration/decode_configuration.rb#6
  def verify_sub=(_arg0); end
end

# source://jwt//lib/jwt/configuration/jwk_configuration.rb#8
class JWT::Configuration::JwkConfiguration
  # @return [JwkConfiguration] a new instance of JwkConfiguration
  #
  # source://jwt//lib/jwt/configuration/jwk_configuration.rb#9
  def initialize; end

  # Returns the value of attribute kid_generator.
  #
  # source://jwt//lib/jwt/configuration/jwk_configuration.rb#24
  def kid_generator; end

  # Sets the attribute kid_generator
  #
  # @param value the value to set the attribute kid_generator to.
  #
  # source://jwt//lib/jwt/configuration/jwk_configuration.rb#24
  def kid_generator=(_arg0); end

  # source://jwt//lib/jwt/configuration/jwk_configuration.rb#13
  def kid_generator_type=(value); end
end

# Decoding logic for JWT
#
# source://jwt//lib/jwt/decode.rb#11
class JWT::Decode
  # @raise [JWT::DecodeError]
  # @return [Decode] a new instance of Decode
  #
  # source://jwt//lib/jwt/decode.rb#12
  def initialize(jwt, key, verify, options, &keyfinder); end

  # @raise [JWT::DecodeError]
  #
  # source://jwt//lib/jwt/decode.rb#24
  def decode_segments; end

  private

  # source://jwt//lib/jwt/decode.rb#140
  def alg_in_header; end

  # source://jwt//lib/jwt/decode.rb#90
  def allowed_algorithms; end

  # source://jwt//lib/jwt/decode.rb#72
  def allowed_and_valid_algorithms; end

  # source://jwt//lib/jwt/decode.rb#136
  def decode_signature; end

  # @raise [JWT::DecodeError]
  #
  # source://jwt//lib/jwt/decode.rb#107
  def find_key(&keyfinder); end

  # source://jwt//lib/jwt/decode.rb#82
  def given_algorithms; end

  # source://jwt//lib/jwt/decode.rb#144
  def header; end

  # @return [Boolean]
  #
  # source://jwt//lib/jwt/decode.rb#132
  def none_algorithm?; end

  # source://jwt//lib/jwt/decode.rb#156
  def parse_and_decode(segment); end

  # source://jwt//lib/jwt/decode.rb#148
  def payload; end

  # source://jwt//lib/jwt/decode.rb#94
  def resolve_allowed_algorithms; end

  # source://jwt//lib/jwt/decode.rb#128
  def segment_length; end

  # source://jwt//lib/jwt/decode.rb#58
  def set_key; end

  # source://jwt//lib/jwt/decode.rb#152
  def signing_input; end

  # Move algorithms matching the JWT alg header to the beginning of the list
  #
  # source://jwt//lib/jwt/decode.rb#101
  def sort_by_alg_header(algs); end

  # @raise [JWT::DecodeError]
  #
  # source://jwt//lib/jwt/decode.rb#120
  def validate_segment_count!; end

  # @raise [JWT::IncorrectAlgorithm]
  #
  # source://jwt//lib/jwt/decode.rb#52
  def verify_algo; end

  # source://jwt//lib/jwt/decode.rb#115
  def verify_claims; end

  # @raise [JWT::DecodeError]
  #
  # source://jwt//lib/jwt/decode.rb#40
  def verify_signature; end

  # @return [Boolean]
  #
  # source://jwt//lib/jwt/decode.rb#66
  def verify_signature_for?(key); end
end

# Order is very important - first check for string keys, next for symbols
#
# source://jwt//lib/jwt/decode.rb#77
JWT::Decode::ALGORITHM_KEYS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/error.rb#5
class JWT::DecodeError < ::StandardError; end

# Deprecations module to handle deprecation warnings in the gem
#
# source://jwt//lib/jwt/deprecations.rb#5
module JWT::Deprecations
  class << self
    # source://jwt//lib/jwt/deprecations.rb#7
    def warning(message); end

    private

    # source://jwt//lib/jwt/deprecations.rb#20
    def record_warned(message); end
  end
end

# Encoding logic for JWT
#
# source://jwt//lib/jwt/encode.rb#9
class JWT::Encode
  # @return [Encode] a new instance of Encode
  #
  # source://jwt//lib/jwt/encode.rb#12
  def initialize(options); end

  # source://jwt//lib/jwt/encode.rb#20
  def segments; end

  private

  # source://jwt//lib/jwt/encode.rb#69
  def combine(*parts); end

  # source://jwt//lib/jwt/encode.rb#65
  def encode_data(data); end

  # source://jwt//lib/jwt/encode.rb#43
  def encode_header; end

  # source://jwt//lib/jwt/encode.rb#47
  def encode_payload; end

  # source://jwt//lib/jwt/encode.rb#61
  def encode_signature; end

  # source://jwt//lib/jwt/encode.rb#27
  def encoded_header; end

  # source://jwt//lib/jwt/encode.rb#39
  def encoded_header_and_payload; end

  # source://jwt//lib/jwt/encode.rb#31
  def encoded_payload; end

  # source://jwt//lib/jwt/encode.rb#35
  def encoded_signature; end

  # source://jwt//lib/jwt/encode.rb#51
  def signature; end

  # source://jwt//lib/jwt/encode.rb#55
  def validate_claims!; end
end

# source://jwt//lib/jwt/encode.rb#10
JWT::Encode::ALG_KEY = T.let(T.unsafe(nil), String)

# source://jwt//lib/jwt/error.rb#4
class JWT::EncodeError < ::StandardError; end

# source://jwt//lib/jwt/error.rb#9
class JWT::ExpiredSignature < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#11
class JWT::ImmatureSignature < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#10
class JWT::IncorrectAlgorithm < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#15
class JWT::InvalidAudError < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#14
class JWT::InvalidIatError < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#12
class JWT::InvalidIssuerError < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#17
class JWT::InvalidJtiError < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#18
class JWT::InvalidPayload < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#16
class JWT::InvalidSubError < ::JWT::DecodeError; end

# JSON wrapper
#
# source://jwt//lib/jwt/json.rb#7
class JWT::JSON
  class << self
    # source://jwt//lib/jwt/json.rb#9
    def generate(data); end

    # source://jwt//lib/jwt/json.rb#13
    def parse(data); end
  end
end

# source://jwt//lib/jwt/jwa/hmac.rb#4
module JWT::JWA
  class << self
    # source://jwt//lib/jwt/jwa.rb#37
    def create(algorithm); end

    # source://jwt//lib/jwt/jwa.rb#33
    def find(algorithm); end

    # @return [Boolean]
    #
    # source://jwt//lib/jwt/jwa.rb#43
    def implementation?(algorithm); end

    private

    # source://jwt//lib/jwt/jwa.rb#50
    def indexed; end
  end
end

# source://jwt//lib/jwt/jwa.rb#22
JWT::JWA::ALGOS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwa/ecdsa.rb#5
module JWT::JWA::Ecdsa
  private

  # source://jwt//lib/jwt/jwa/ecdsa.rb#70
  def asn1_to_raw(signature, public_key); end

  # source://jwt//lib/jwt/jwa/ecdsa.rb#57
  def curve_by_name(name); end

  # source://jwt//lib/jwt/jwa/ecdsa.rb#63
  def raw_to_asn1(signature, private_key); end

  # source://jwt//lib/jwt/jwa/ecdsa.rb#33
  def sign(algorithm, msg, key); end

  # source://jwt//lib/jwt/jwa/ecdsa.rb#44
  def verify(algorithm, public_key, signing_input, signature); end

  class << self
    # source://jwt//lib/jwt/jwa/ecdsa.rb#70
    def asn1_to_raw(signature, public_key); end

    # source://jwt//lib/jwt/jwa/ecdsa.rb#57
    def curve_by_name(name); end

    # source://jwt//lib/jwt/jwa/ecdsa.rb#63
    def raw_to_asn1(signature, private_key); end

    # source://jwt//lib/jwt/jwa/ecdsa.rb#33
    def sign(algorithm, msg, key); end

    # source://jwt//lib/jwt/jwa/ecdsa.rb#44
    def verify(algorithm, public_key, signing_input, signature); end
  end
end

# source://jwt//lib/jwt/jwa/ecdsa.rb#8
JWT::JWA::Ecdsa::NAMED_CURVES = T.let(T.unsafe(nil), Hash)

# source://jwt//lib/jwt/jwa/ecdsa.rb#31
JWT::JWA::Ecdsa::SUPPORTED = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwa/eddsa.rb#5
module JWT::JWA::Eddsa
  class << self
    # source://jwt//lib/jwt/jwa/eddsa.rb#10
    def sign(algorithm, msg, key); end

    # source://jwt//lib/jwt/jwa/eddsa.rb#20
    def verify(algorithm, public_key, signing_input, signature); end

    private

    # @raise [IncorrectAlgorithm]
    #
    # source://jwt//lib/jwt/jwa/eddsa.rb#34
    def validate_algorithm!(algorithm); end
  end
end

# source://jwt//lib/jwt/jwa/eddsa.rb#6
JWT::JWA::Eddsa::SUPPORTED = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwa/eddsa.rb#7
JWT::JWA::Eddsa::SUPPORTED_DOWNCASED = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwa/hmac.rb#5
module JWT::JWA::Hmac
  private

  # source://jwt//lib/jwt/jwa/hmac.rb#16
  def sign(algorithm, msg, key); end

  # source://jwt//lib/jwt/jwa/hmac.rb#30
  def verify(algorithm, key, signing_input, signature); end

  class << self
    # source://jwt//lib/jwt/jwa/hmac.rb#16
    def sign(algorithm, msg, key); end

    # source://jwt//lib/jwt/jwa/hmac.rb#30
    def verify(algorithm, key, signing_input, signature); end
  end
end

# source://jwt//lib/jwt/jwa/hmac.rb#8
JWT::JWA::Hmac::MAPPING = T.let(T.unsafe(nil), Hash)

# source://jwt//lib/jwt/jwa/hmac.rb#14
JWT::JWA::Hmac::SUPPORTED = T.let(T.unsafe(nil), Array)

# Copy of https://github.com/rails/rails/blob/v7.0.3.1/activesupport/lib/active_support/security_utils.rb
#
# source://jwt//lib/jwt/jwa/hmac.rb#36
module JWT::JWA::Hmac::SecurityUtils
  private

  # :nocov:
  #
  # @raise [ArgumentError]
  #
  # source://jwt//lib/jwt/jwa/hmac.rb#43
  def fixed_length_secure_compare(a, b); end

  # Secure string comparison for strings of variable length.
  #
  # While a timing attack would not be able to discern the content of
  # a secret compared via secure_compare, it is possible to determine
  # the secret length. This should be considered when using secure_compare
  # to compare weak, short secrets to user input.
  #
  # source://jwt//lib/jwt/jwa/hmac.rb#67
  def secure_compare(a, b); end

  class << self
    # :nocov:
    #
    # @raise [ArgumentError]
    #
    # source://jwt//lib/jwt/jwa/hmac.rb#43
    def fixed_length_secure_compare(a, b); end

    # Secure string comparison for strings of variable length.
    #
    # While a timing attack would not be able to discern the content of
    # a secret compared via secure_compare, it is possible to determine
    # the secret length. This should be considered when using secure_compare
    # to compare weak, short secrets to user input.
    #
    # source://jwt//lib/jwt/jwa/hmac.rb#67
    def secure_compare(a, b); end
  end
end

# source://jwt//lib/jwt/jwa/none.rb#5
module JWT::JWA::None
  private

  # source://jwt//lib/jwt/jwa/none.rb#10
  def sign(*_arg0); end

  # source://jwt//lib/jwt/jwa/none.rb#14
  def verify(*_arg0); end

  class << self
    # source://jwt//lib/jwt/jwa/none.rb#10
    def sign(*_arg0); end

    # source://jwt//lib/jwt/jwa/none.rb#14
    def verify(*_arg0); end
  end
end

# source://jwt//lib/jwt/jwa/none.rb#8
JWT::JWA::None::SUPPORTED = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwa/ps.rb#5
module JWT::JWA::Ps
  private

  # source://jwt//lib/jwt/jwa/ps.rb#12
  def sign(algorithm, msg, key); end

  # source://jwt//lib/jwt/jwa/ps.rb#22
  def verify(algorithm, public_key, signing_input, signature); end

  class << self
    # source://jwt//lib/jwt/jwa/ps.rb#12
    def sign(algorithm, msg, key); end

    # source://jwt//lib/jwt/jwa/ps.rb#22
    def verify(algorithm, public_key, signing_input, signature); end
  end
end

# source://jwt//lib/jwt/jwa/ps.rb#10
JWT::JWA::Ps::SUPPORTED = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwa/rsa.rb#5
module JWT::JWA::Rsa
  private

  # source://jwt//lib/jwt/jwa/rsa.rb#10
  def sign(algorithm, msg, key); end

  # source://jwt//lib/jwt/jwa/rsa.rb#18
  def verify(algorithm, public_key, signing_input, signature); end

  class << self
    # source://jwt//lib/jwt/jwa/rsa.rb#10
    def sign(algorithm, msg, key); end

    # source://jwt//lib/jwt/jwa/rsa.rb#18
    def verify(algorithm, public_key, signing_input, signature); end
  end
end

# source://jwt//lib/jwt/jwa/rsa.rb#8
JWT::JWA::Rsa::SUPPORTED = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwa/unsupported.rb#5
module JWT::JWA::Unsupported
  private

  # source://jwt//lib/jwt/jwa/unsupported.rb#10
  def sign(*_arg0); end

  # source://jwt//lib/jwt/jwa/unsupported.rb#14
  def verify(*_arg0); end

  class << self
    # @raise [NotImplementedError]
    #
    # source://jwt//lib/jwt/jwa/unsupported.rb#10
    def sign(*_arg0); end

    # @raise [JWT::VerificationError]
    #
    # source://jwt//lib/jwt/jwa/unsupported.rb#14
    def verify(*_arg0); end
  end
end

# source://jwt//lib/jwt/jwa/unsupported.rb#8
JWT::JWA::Unsupported::SUPPORTED = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwa/wrapper.rb#5
class JWT::JWA::Wrapper
  # @return [Wrapper] a new instance of Wrapper
  #
  # source://jwt//lib/jwt/jwa/wrapper.rb#8
  def initialize(alg, cls); end

  # Returns the value of attribute alg.
  #
  # source://jwt//lib/jwt/jwa/wrapper.rb#6
  def alg; end

  # Returns the value of attribute cls.
  #
  # source://jwt//lib/jwt/jwa/wrapper.rb#6
  def cls; end

  # source://jwt//lib/jwt/jwa/wrapper.rb#17
  def sign(data:, signing_key:); end

  # @return [Boolean]
  #
  # source://jwt//lib/jwt/jwa/wrapper.rb#13
  def valid_alg?(alg_to_check); end

  # source://jwt//lib/jwt/jwa/wrapper.rb#21
  def verify(data:, signature:, verification_key:); end
end

# source://jwt//lib/jwt/jwk/kid_as_key_digest.rb#4
module JWT::JWK
  class << self
    # source://jwt//lib/jwt/jwk.rb#24
    def classes; end

    # source://jwt//lib/jwt/jwk.rb#9
    def create_from(key, params = T.unsafe(nil), options = T.unsafe(nil)); end

    # source://jwt//lib/jwt/jwk.rb#9
    def import(key, params = T.unsafe(nil), options = T.unsafe(nil)); end

    # source://jwt//lib/jwt/jwk.rb#9
    def new(key, params = T.unsafe(nil), options = T.unsafe(nil)); end

    private

    # source://jwt//lib/jwt/jwk.rb#38
    def generate_mappings; end

    # source://jwt//lib/jwt/jwk.rb#34
    def mappings; end
  end
end

# source://jwt//lib/jwt/jwk/ec.rb#7
class JWT::JWK::EC < ::JWT::JWK::KeyBase
  # @return [EC] a new instance of EC
  #
  # source://jwt//lib/jwt/jwk/ec.rb#16
  def initialize(key, params = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://jwt//lib/jwt/jwk/ec.rb#67
  def []=(key, value); end

  # source://jwt//lib/jwt/jwk/ec.rb#54
  def export(options = T.unsafe(nil)); end

  # source://jwt//lib/jwt/jwk/ec.rb#60
  def key_digest; end

  # source://jwt//lib/jwt/jwk/ec.rb#30
  def keypair; end

  # source://jwt//lib/jwt/jwk/ec.rb#50
  def members; end

  # @return [Boolean]
  #
  # source://jwt//lib/jwt/jwk/ec.rb#34
  def private?; end

  # source://jwt//lib/jwt/jwk/ec.rb#46
  def public_key; end

  # source://jwt//lib/jwt/jwk/ec.rb#38
  def signing_key; end

  # source://jwt//lib/jwt/jwk/ec.rb#42
  def verify_key; end

  private

  # @raise [ArgumentError]
  #
  # source://jwt//lib/jwt/jwk/ec.rb#95
  def check_jwk_params!(key_params, params); end

  # source://jwt//lib/jwt/jwk/ec.rb#145
  def create_ec_key(jwk_crv, jwk_x, jwk_y, jwk_d); end

  # source://jwt//lib/jwt/jwk/ec.rb#208
  def decode_octets(base64_encoded_coordinate); end

  # source://jwt//lib/jwt/jwk/ec.rb#77
  def ec_key; end

  # source://jwt//lib/jwt/jwk/ec.rb#122
  def encode_octets(octets); end

  # source://jwt//lib/jwt/jwk/ec.rb#128
  def encode_open_ssl_bn(key_part); end

  # source://jwt//lib/jwt/jwk/ec.rb#81
  def extract_key_params(key); end

  # source://jwt//lib/jwt/jwk/ec.rb#101
  def keypair_components(ec_keypair); end

  # source://jwt//lib/jwt/jwk/ec.rb#132
  def parse_ec_key(key); end

  class << self
    # source://jwt//lib/jwt/jwk/ec.rb#232
    def import(jwk_data); end

    # source://jwt//lib/jwt/jwk/ec.rb#236
    def to_openssl_curve(crv); end
  end
end

# source://jwt//lib/jwt/jwk/ec.rb#10
JWT::JWK::EC::BINARY = T.let(T.unsafe(nil), Integer)

# source://jwt//lib/jwt/jwk/ec.rb#13
JWT::JWK::EC::EC_KEY_ELEMENTS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/ec.rb#12
JWT::JWK::EC::EC_PRIVATE_KEY_ELEMENTS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/ec.rb#11
JWT::JWK::EC::EC_PUBLIC_KEY_ELEMENTS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/ec.rb#8
JWT::JWK::EC::KTY = T.let(T.unsafe(nil), String)

# source://jwt//lib/jwt/jwk/ec.rb#9
JWT::JWK::EC::KTYS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/ec.rb#14
JWT::JWK::EC::ZERO_BYTE = T.let(T.unsafe(nil), String)

# source://jwt//lib/jwt/jwk/hmac.rb#5
class JWT::JWK::HMAC < ::JWT::JWK::KeyBase
  # @return [HMAC] a new instance of HMAC
  #
  # source://jwt//lib/jwt/jwk/hmac.rb#12
  def initialize(key, params = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://jwt//lib/jwt/jwk/hmac.rb#63
  def []=(key, value); end

  # See https://tools.ietf.org/html/rfc7517#appendix-A.3
  #
  # source://jwt//lib/jwt/jwk/hmac.rb#47
  def export(options = T.unsafe(nil)); end

  # source://jwt//lib/jwt/jwk/hmac.rb#57
  def key_digest; end

  # source://jwt//lib/jwt/jwk/hmac.rb#26
  def keypair; end

  # source://jwt//lib/jwt/jwk/hmac.rb#53
  def members; end

  # @return [Boolean]
  #
  # source://jwt//lib/jwt/jwk/hmac.rb#30
  def private?; end

  # source://jwt//lib/jwt/jwk/hmac.rb#34
  def public_key; end

  # source://jwt//lib/jwt/jwk/hmac.rb#42
  def signing_key; end

  # source://jwt//lib/jwt/jwk/hmac.rb#38
  def verify_key; end

  private

  # @raise [ArgumentError]
  #
  # source://jwt//lib/jwt/jwk/hmac.rb#90
  def check_jwk(keypair, params); end

  # source://jwt//lib/jwt/jwk/hmac.rb#77
  def extract_key_params(key); end

  # source://jwt//lib/jwt/jwk/hmac.rb#73
  def secret; end

  class << self
    # source://jwt//lib/jwt/jwk/hmac.rb#97
    def import(jwk_data); end
  end
end

# source://jwt//lib/jwt/jwk/hmac.rb#10
JWT::JWK::HMAC::HMAC_KEY_ELEMENTS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/hmac.rb#9
JWT::JWK::HMAC::HMAC_PRIVATE_KEY_ELEMENTS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/hmac.rb#8
JWT::JWK::HMAC::HMAC_PUBLIC_KEY_ELEMENTS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/hmac.rb#6
JWT::JWK::HMAC::KTY = T.let(T.unsafe(nil), String)

# source://jwt//lib/jwt/jwk/hmac.rb#7
JWT::JWK::HMAC::KTYS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/key_base.rb#5
class JWT::JWK::KeyBase
  # @return [KeyBase] a new instance of KeyBase
  #
  # source://jwt//lib/jwt/jwk/key_base.rb#11
  def initialize(options, params = T.unsafe(nil)); end

  # source://jwt//lib/jwt/jwk/key_base.rb#46
  def <=>(other); end

  # source://jwt//lib/jwt/jwk/key_base.rb#40
  def ==(other); end

  # source://jwt//lib/jwt/jwk/key_base.rb#32
  def [](key); end

  # source://jwt//lib/jwt/jwk/key_base.rb#36
  def []=(key, value); end

  # source://jwt//lib/jwt/jwk/key_base.rb#40
  def eql?(other); end

  # source://jwt//lib/jwt/jwk/key_base.rb#28
  def hash; end

  # source://jwt//lib/jwt/jwk/key_base.rb#24
  def kid; end

  private

  # Returns the value of attribute parameters.
  #
  # source://jwt//lib/jwt/jwk/key_base.rb#54
  def parameters; end

  class << self
    # @private
    #
    # source://jwt//lib/jwt/jwk/key_base.rb#6
    def inherited(klass); end
  end
end

# source://jwt//lib/jwt/jwk/key_finder.rb#5
class JWT::JWK::KeyFinder
  # @return [KeyFinder] a new instance of KeyFinder
  #
  # source://jwt//lib/jwt/jwk/key_finder.rb#6
  def initialize(options); end

  # @raise [::JWT::DecodeError]
  #
  # source://jwt//lib/jwt/jwk/key_finder.rb#17
  def key_for(kid); end

  private

  # source://jwt//lib/jwt/jwk/key_finder.rb#31
  def resolve_key(kid); end
end

# source://jwt//lib/jwt/jwk/kid_as_key_digest.rb#5
class JWT::JWK::KidAsKeyDigest
  # @return [KidAsKeyDigest] a new instance of KidAsKeyDigest
  #
  # source://jwt//lib/jwt/jwk/kid_as_key_digest.rb#6
  def initialize(jwk); end

  # source://jwt//lib/jwt/jwk/kid_as_key_digest.rb#10
  def generate; end
end

# source://jwt//lib/jwt/jwk/rsa.rb#5
class JWT::JWK::RSA < ::JWT::JWK::KeyBase
  # @return [RSA] a new instance of RSA
  #
  # source://jwt//lib/jwt/jwk/rsa.rb#16
  def initialize(key, params = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://jwt//lib/jwt/jwk/rsa.rb#66
  def []=(key, value); end

  # source://jwt//lib/jwt/jwk/rsa.rb#50
  def export(options = T.unsafe(nil)); end

  # source://jwt//lib/jwt/jwk/rsa.rb#60
  def key_digest; end

  # source://jwt//lib/jwt/jwk/rsa.rb#30
  def keypair; end

  # source://jwt//lib/jwt/jwk/rsa.rb#56
  def members; end

  # @return [Boolean]
  #
  # source://jwt//lib/jwt/jwk/rsa.rb#34
  def private?; end

  # source://jwt//lib/jwt/jwk/rsa.rb#38
  def public_key; end

  # source://jwt//lib/jwt/jwk/rsa.rb#42
  def signing_key; end

  # source://jwt//lib/jwt/jwk/rsa.rb#46
  def verify_key; end

  private

  # @raise [ArgumentError]
  #
  # source://jwt//lib/jwt/jwk/rsa.rb#94
  def check_jwk_params!(key_params, params); end

  # source://jwt//lib/jwt/jwk/rsa.rb#126
  def decode_open_ssl_bn(jwk_data); end

  # source://jwt//lib/jwt/jwk/rsa.rb#120
  def encode_open_ssl_bn(key_part); end

  # source://jwt//lib/jwt/jwk/rsa.rb#80
  def extract_key_params(key); end

  # source://jwt//lib/jwt/jwk/rsa.rb#114
  def jwk_attributes(*attributes); end

  # source://jwt//lib/jwt/jwk/rsa.rb#100
  def parse_rsa_key(key); end

  # source://jwt//lib/jwt/jwk/rsa.rb#76
  def rsa_key; end

  class << self
    # source://jwt//lib/jwt/jwk/rsa.rb#141
    def create_rsa_key(rsa_parameters); end

    # source://jwt//lib/jwt/jwk/rsa.rb#169
    def create_rsa_key_using_accessors(rsa_parameters); end

    # source://jwt//lib/jwt/jwk/rsa.rb#141
    def create_rsa_key_using_der(rsa_parameters); end

    # source://jwt//lib/jwt/jwk/rsa.rb#159
    def create_rsa_key_using_sets(rsa_parameters); end

    # source://jwt//lib/jwt/jwk/rsa.rb#135
    def decode_open_ssl_bn(jwk_data); end

    # source://jwt//lib/jwt/jwk/rsa.rb#131
    def import(jwk_data); end

    # @raise [JWT::JWKError]
    #
    # source://jwt//lib/jwt/jwk/rsa.rb#184
    def validate_rsa_parameters!(rsa_parameters); end
  end
end

# source://jwt//lib/jwt/jwk/rsa.rb#6
JWT::JWK::RSA::BINARY = T.let(T.unsafe(nil), Integer)

# source://jwt//lib/jwt/jwk/rsa.rb#7
JWT::JWK::RSA::KTY = T.let(T.unsafe(nil), String)

# source://jwt//lib/jwt/jwk/rsa.rb#8
JWT::JWK::RSA::KTYS = T.let(T.unsafe(nil), Array)

# https://www.rfc-editor.org/rfc/rfc3447#appendix-A.1.2
#
# source://jwt//lib/jwt/jwk/rsa.rb#14
JWT::JWK::RSA::RSA_ASN1_SEQUENCE = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/rsa.rb#11
JWT::JWK::RSA::RSA_KEY_ELEMENTS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/rsa.rb#13
JWT::JWK::RSA::RSA_OPT_PARAMS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/rsa.rb#10
JWT::JWK::RSA::RSA_PRIVATE_KEY_ELEMENTS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/rsa.rb#9
JWT::JWK::RSA::RSA_PUBLIC_KEY_ELEMENTS = T.let(T.unsafe(nil), Array)

# source://jwt//lib/jwt/jwk/set.rb#7
class JWT::JWK::Set
  include ::Enumerable
  extend ::Forwardable

  # @return [Set] a new instance of Set
  #
  # source://jwt//lib/jwt/jwk/set.rb#13
  def initialize(jwks = T.unsafe(nil), options = T.unsafe(nil)); end

  # source://jwt//lib/jwt/jwk/set.rb#58
  def +(enum); end

  # source://jwt//lib/jwt/jwk/set.rb#62
  def <<(key); end

  # source://jwt//lib/jwt/jwk/set.rb#67
  def ==(other); end

  # source://jwt//lib/jwt/jwk/set.rb#62
  def add(key); end

  # source://forwardable/1.3.3/forwardable.rb#231
  def delete(*args, **_arg1, &block); end

  # source://forwardable/1.3.3/forwardable.rb#231
  def dig(*args, **_arg1, &block); end

  # source://forwardable/1.3.3/forwardable.rb#231
  def each(*args, **_arg1, &block); end

  # source://jwt//lib/jwt/jwk/set.rb#67
  def eql?(other); end

  # source://jwt//lib/jwt/jwk/set.rb#31
  def export(options = T.unsafe(nil)); end

  # source://jwt//lib/jwt/jwk/set.rb#37
  def filter!(&block); end

  # Returns the value of attribute keys.
  #
  # source://jwt//lib/jwt/jwk/set.rb#11
  def keys; end

  # source://forwardable/1.3.3/forwardable.rb#231
  def length(*args, **_arg1, &block); end

  # source://jwt//lib/jwt/jwk/set.rb#53
  def merge(enum); end

  # source://jwt//lib/jwt/jwk/set.rb#43
  def reject!(&block); end

  # source://jwt//lib/jwt/jwk/set.rb#37
  def select!(&block); end

  # source://forwardable/1.3.3/forwardable.rb#231
  def size(*args, **_arg1, &block); end

  # source://jwt//lib/jwt/jwk/set.rb#58
  def union(enum); end

  # source://jwt//lib/jwt/jwk/set.rb#49
  def uniq!(&block); end

  # For symbolic manipulation
  #
  # source://jwt//lib/jwt/jwk/set.rb#58
  def |(enum); end
end

# https://tools.ietf.org/html/rfc7638
#
# source://jwt//lib/jwt/jwk/thumbprint.rb#6
class JWT::JWK::Thumbprint
  # @return [Thumbprint] a new instance of Thumbprint
  #
  # source://jwt//lib/jwt/jwk/thumbprint.rb#9
  def initialize(jwk); end

  # source://jwt//lib/jwt/jwk/thumbprint.rb#13
  def generate; end

  # Returns the value of attribute jwk.
  #
  # source://jwt//lib/jwt/jwk/thumbprint.rb#7
  def jwk; end

  # source://jwt//lib/jwt/jwk/thumbprint.rb#13
  def to_s; end
end

# source://jwt//lib/jwt/error.rb#22
class JWT::JWKError < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#19
class JWT::MissingRequiredClaim < ::JWT::DecodeError; end

# source://jwt//lib/jwt/error.rb#6
class JWT::RequiredDependencyError < ::StandardError; end

# source://jwt//lib/jwt/error.rb#13
class JWT::UnsupportedEcdsaCurve < ::JWT::IncorrectAlgorithm; end

# Moments version builder module
#
# source://jwt//lib/jwt/version.rb#10
module JWT::VERSION; end

# major version
#
# source://jwt//lib/jwt/version.rb#12
JWT::VERSION::MAJOR = T.let(T.unsafe(nil), Integer)

# minor version
#
# source://jwt//lib/jwt/version.rb#14
JWT::VERSION::MINOR = T.let(T.unsafe(nil), Integer)

# alpha, beta, etc. tag
#
# source://jwt//lib/jwt/version.rb#18
JWT::VERSION::PRE = T.let(T.unsafe(nil), T.untyped)

# Build version string
#
# source://jwt//lib/jwt/version.rb#21
JWT::VERSION::STRING = T.let(T.unsafe(nil), String)

# tiny version
#
# source://jwt//lib/jwt/version.rb#16
JWT::VERSION::TINY = T.let(T.unsafe(nil), Integer)

# source://jwt//lib/jwt/error.rb#8
class JWT::VerificationError < ::JWT::DecodeError; end

# JWT verify methods
#
# source://jwt//lib/jwt/verify.rb#7
class JWT::Verify
  # @return [Verify] a new instance of Verify
  #
  # source://jwt//lib/jwt/verify.rb#28
  def initialize(payload, options); end

  # @raise [JWT::InvalidAudError]
  #
  # source://jwt//lib/jwt/verify.rb#33
  def verify_aud; end

  # @raise [JWT::ExpiredSignature]
  #
  # source://jwt//lib/jwt/verify.rb#40
  def verify_expiration; end

  # @raise [JWT::InvalidIatError]
  #
  # source://jwt//lib/jwt/verify.rb#45
  def verify_iat; end

  # source://jwt//lib/jwt/verify.rb#52
  def verify_iss; end

  # source://jwt//lib/jwt/verify.rb#67
  def verify_jti; end

  # @raise [JWT::ImmatureSignature]
  #
  # source://jwt//lib/jwt/verify.rb#79
  def verify_not_before; end

  # source://jwt//lib/jwt/verify.rb#91
  def verify_required_claims; end

  # @raise [JWT::InvalidSubError]
  #
  # source://jwt//lib/jwt/verify.rb#84
  def verify_sub; end

  private

  # @return [Boolean]
  #
  # source://jwt//lib/jwt/verify.rb#113
  def contains_key?(payload, key); end

  # source://jwt//lib/jwt/verify.rb#105
  def exp_leeway; end

  # source://jwt//lib/jwt/verify.rb#101
  def global_leeway; end

  # source://jwt//lib/jwt/verify.rb#109
  def nbf_leeway; end

  class << self
    # source://jwt//lib/jwt/verify.rb#14
    def verify_aud(payload, options); end

    # source://jwt//lib/jwt/verify.rb#19
    def verify_claims(payload, options); end

    # source://jwt//lib/jwt/verify.rb#14
    def verify_expiration(payload, options); end

    # source://jwt//lib/jwt/verify.rb#14
    def verify_iat(payload, options); end

    # source://jwt//lib/jwt/verify.rb#14
    def verify_iss(payload, options); end

    # source://jwt//lib/jwt/verify.rb#14
    def verify_jti(payload, options); end

    # source://jwt//lib/jwt/verify.rb#14
    def verify_not_before(payload, options); end

    # source://jwt//lib/jwt/verify.rb#14
    def verify_required_claims(payload, options); end

    # source://jwt//lib/jwt/verify.rb#14
    def verify_sub(payload, options); end
  end
end

# source://jwt//lib/jwt/verify.rb#8
JWT::Verify::DEFAULTS = T.let(T.unsafe(nil), Hash)

# If the x5c header certificate chain can be validated by trusted root
# certificates, and none of the certificates are revoked, returns the public
# key from the first certificate.
# See https://tools.ietf.org/html/rfc7515#section-4.1.6
#
# source://jwt//lib/jwt/x5c_key_finder.rb#8
class JWT::X5cKeyFinder
  # @raise [ArgumentError]
  # @return [X5cKeyFinder] a new instance of X5cKeyFinder
  #
  # source://jwt//lib/jwt/x5c_key_finder.rb#9
  def initialize(root_certificates, crls = T.unsafe(nil)); end

  # source://jwt//lib/jwt/x5c_key_finder.rb#15
  def from(x5c_header_or_certificates); end

  private

  # source://jwt//lib/jwt/x5c_key_finder.rb#33
  def build_store(root_certificates, crls); end

  # source://jwt//lib/jwt/x5c_key_finder.rb#42
  def parse_certificates(x5c_header_or_certificates); end
end

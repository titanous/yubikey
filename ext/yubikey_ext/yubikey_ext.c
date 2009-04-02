#include "ruby.h"
#include "yubikey.h"

// ModHex.decode('modhex_string')
static VALUE
modhex_decode(VALUE self, VALUE modhex_string) {
  char* modhex_string_ptr = StringValuePtr(modhex_string);
  size_t modhex_string_size = strlen(modhex_string_ptr);
  size_t decoded_string_size = modhex_string_size/2;
  char* decoded_string;
  
   if (modhex_string_size % 2 != 0)
     rb_raise(rb_eArgError, "ModHex string length is not even");
  
  yubikey_modhex_decode(decoded_string, modhex_string_ptr, modhex_string_size);
  
  return rb_str_new(decoded_string, decoded_string_size);
}

// ModHex.encode('string')
static VALUE
modhex_encode(VALUE self, VALUE string) {
  char* string_ptr = StringValuePtr(string);
  size_t string_size = strlen(string_ptr);
  char* modhex_string;
  
  yubikey_modhex_encode(modhex_string, string_ptr, string_size);
  return rb_str_new2(modhex_string);
}

// AES.decrypt('state', 'key')
static VALUE
aes_decrypt(VALUE self, VALUE state, VALUE key) {
  char* state_ptr = StringValuePtr(state);
  char* key_ptr = StringValuePtr(key);
  
  if (strlen(state_ptr) != YUBIKEY_BLOCK_SIZE || strlen(key_ptr) != YUBIKEY_KEY_SIZE)
    rb_raise(rb_eArgError, "key and state must be 16 bytes");
  
  yubikey_aes_decrypt((uint8_t*)state_ptr, (uint8_t*)key_ptr);
  
  return rb_str_new(state_ptr, YUBIKEY_BLOCK_SIZE);
}

void
Init_yubikey_ext() {
  VALUE rb_mYubikey = rb_define_module("Yubikey");
  VALUE rb_mYubikeyAES = rb_define_module_under(rb_mYubikey, "AES");
  VALUE rb_mYubikeyModHex = rb_define_module_under(rb_mYubikey, "ModHex");
  
  rb_define_module_function(rb_mYubikeyModHex, "decode", modhex_decode, 1);
  rb_define_module_function(rb_mYubikeyModHex, "encode", modhex_encode, 1);
  rb_define_module_function(rb_mYubikeyAES, "decrypt", aes_decrypt, 2);
}

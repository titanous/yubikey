#include "ruby.h"
#include "yubikey.h"

// Yubikey::ModHex.decode('modhex_string')
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

// Yubikey::AES.decrypt('state', 'key')
static VALUE
aes_decrypt(VALUE self, VALUE state, VALUE key) {
  char* state_ptr = StringValuePtr(state);
  char* key_ptr = StringValuePtr(key);
  
  if (RSTRING(state)->len != YUBIKEY_BLOCK_SIZE || RSTRING(key)->len != YUBIKEY_KEY_SIZE)
    rb_raise(rb_eArgError, "key and state must be 16 bytes");
  
  yubikey_aes_decrypt((uint8_t*)state_ptr, (uint8_t*)key_ptr);
  
  return rb_str_new(state_ptr, YUBIKEY_BLOCK_SIZE);
}

// Yubikey::CRC.valid?('token')
static VALUE
crc_check(VALUE self, VALUE token) {
  char* token_ptr = StringValuePtr(token);
  
  if (RSTRING(token)->len != YUBIKEY_BLOCK_SIZE)
    rb_raise(rb_eArgError, "token must be 16 bytes");
  
  return yubikey_crc_ok_p((uint8_t*)token_ptr) ? Qtrue : Qfalse;
}

void
Init_yubikey_ext() {
  VALUE rb_mYubikey = rb_define_module("Yubikey");
  VALUE rb_mYubikeyAES = rb_define_module_under(rb_mYubikey, "AES");
  VALUE rb_mYubikeyModHex = rb_define_module_under(rb_mYubikey, "ModHex");
  VALUE rb_mYubikeyCRC = rb_define_module_under(rb_mYubikey, "CRC");
  
  rb_define_module_function(rb_mYubikeyModHex, "decode", modhex_decode, 1);
  rb_define_module_function(rb_mYubikeyAES, "decrypt", aes_decrypt, 2);
  rb_define_module_function(rb_mYubikeyCRC, "valid?", crc_check, 1);
}

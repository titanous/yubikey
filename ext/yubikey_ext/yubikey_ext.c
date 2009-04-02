#include "ruby.h"
#include "yubikey.h"

// ModHex.decode('modhex_string')
static VALUE
modhex_decode(VALUE self, VALUE modhex_string) {
  char* modhex_string_ptr = StringValuePtr(modhex_string);
  int modhex_string_size = strlen(modhex_string_ptr);
  char* decoded_string;
  
   if (modhex_string_size % 2 != 0)
     rb_raise(rb_eRuntimeError, "ModHex string length is not even");
  
  yubikey_modhex_decode(decoded_string, modhex_string_ptr, modhex_string_size);
  return rb_str_new2(decoded_string);
}

// ModHex.encode('string')
static VALUE
modhex_encode(VALUE self, VALUE string) {
  char* string_ptr = StringValuePtr(string);
  int string_size = strlen(string_ptr);
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
  VALUE rb_mAES = rb_define_module("AES");
  VALUE rb_mModHex = rb_define_module("ModHex");
  
  rb_define_module_function(rb_mModHex, "decode", modhex_decode, 1);
  rb_define_module_function(rb_mModHex, "encode", modhex_encode, 1);
  rb_define_module_function(rb_mAES, "decrypt", aes_decrypt, 2);
}

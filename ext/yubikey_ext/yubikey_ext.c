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

void
Init_yubikey_ext() {
  VALUE rb_mYubikey = rb_define_module("Yubikey");
  VALUE rb_mYubikeyParse = rb_define_module_under(rb_mYubikey, "Parse");
  VALUE rb_mYubikeyAES = rb_define_module_under(rb_mYubikey, "AES");
  VALUE rb_mYubikeyCRC = rb_define_module_under(rb_mYubikey, "CRC");
  
  VALUE rb_mModHex = rb_define_module("ModHex");
  rb_define_module_function(rb_mModHex, "decode", modhex_decode, 1);
}
#include <unistd.h>
#include <sys/mman.h>
#include <string.h>
#include <stdio.h>
#include "erl_nif.h"

static ERL_NIF_TERM ace_int(ErlNifEnv *env, int argc, const ERL_NIF_TERM argv[])
{
  unsigned int length;
  enif_get_list_length(env, argv[0], &length);
  unsigned char code[length];
  enif_get_string(env, argv[0], &code, length, ERL_NIF_LATIN1);
  void *buf;
  buf = mmap (0, sizeof(code), PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANON, -1,0);
  memcpy (buf, code, sizeof(code));
  int i = ((int (*) (void))buf)();
  return enif_make_int(env, i);
}

static ErlNifFunc nif_funcs[] = {
  {"ace_int", 1, ace_int},
};

ERL_NIF_INIT(Elixir.Ace, nif_funcs, NULL, NULL, NULL, NULL)

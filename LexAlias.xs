#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* cargo-culted from PadWalker */

MODULE = Devel::LexAlias                PACKAGE = Devel::LexAlias

void
lexalias(cur_sv, name, new_rv)
SV*   cur_sv;
char* name;
SV*   new_rv;
  PREINIT:
     CV* cur_cv = (CV*)SvRV(cur_sv);
     AV* padlist = CvPADLIST(cur_cv);
     AV* pad_namelist = (AV*) *av_fetch(padlist, 0, 0);
     AV* pad_vallist  = (AV*) *av_fetch(padlist, av_len(padlist), 0);
     SV* new_sv;
     I32 i;

  CODE:
     if (!SvROK(new_rv)) croak("ref is not a reference");
     new_sv = SvRV(new_rv);

     for (i = 0; i <= av_len(pad_namelist); ++i) {
        SV** name_ptr = av_fetch(pad_namelist, i, 0);
        if (name_ptr) {
          SV* name_sv = *name_ptr;

          if (SvPOKp(name_sv)) {
             char *name_str = SvPVX(name_sv);

             if (!strcmp(name, name_str)) {
                SV* old_sv = (SV*) av_fetch(pad_vallist, i, 0);
                SvREFCNT_dec(old_sv);
                av_store(pad_vallist, i, new_sv);
                SvREFCNT_inc(new_sv);
             }
          }
        }
     }


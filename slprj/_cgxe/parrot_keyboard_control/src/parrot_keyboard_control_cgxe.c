/* Include files */

#include "parrot_keyboard_control_cgxe.h"
#include "m_3YttJ5tzdpTPtVQkledOMC.h"

unsigned int cgxe_parrot_keyboard_control_method_dispatcher(SimStruct* S, int_T
  method, void* data)
{
  if (ssGetChecksum0(S) == 2957915714 &&
      ssGetChecksum1(S) == 1865468864 &&
      ssGetChecksum2(S) == 1580093396 &&
      ssGetChecksum3(S) == 3811833538) {
    method_dispatcher_3YttJ5tzdpTPtVQkledOMC(S, method, data);
    return 1;
  }

  return 0;
}

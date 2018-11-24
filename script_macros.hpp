
/***************************************
**  @File: script_macros.hpp
**  @Author: Sig
**
**  Macro group: System-wide macros
***************************************/
#define DTAS_PREFIX DTAS
#define PREFIXMAIN ADC

/***************************************
**  Macro group: General
**  NOTE: Most of these are taken from Community Base Addons, credits to them guys
***************************************/
#define QUOTE(VAR) #VAR
#define DOUBLES(var1,var2) ##var1##_##var2
#define TRIPLES(var1,var2,var3) ##var1##_##var2##_##var3
#define GVAR(VAR) DOUBLES(PREFIXMAIN,VAR)
#define VARQ(VAR) QUOTE(GVAR(VAR))
#define DVAR(VAR) DOUBLES(DTAS_PREFIX,VAR)
#define FUNC(VAR) TRIPLES(PREFIXMAIN,fnc,VAR)
#define QFNC(VAR) QUOTE(FUNC(VAR))
#define DFUNC(VAR) TRIPLES(DTAS_PREFIX,fnc,VAR)
#define SETVAR(varspace,varname,val,global) (varspace setVariable [varname,val,global])
#define GETVAR(varspace,varname,val) (varspace getVariable [varname,val])

/****************************************
**  Macro group: Maths
**  NOTE: Most of these are taken from Community Base Addons, credits to them guys
*****************************************/
#define INC(VAR) VAR = (VAR) + 1
#define DEC(VAR) VAR = (VAR) - 1
#define ADD(var1,var2) (var1) + (var2)
#define SUB(var1,var2) (var1) - (var2)
#define MULTI(var1,var2) (var1) * (var2)
#define DIVIDE(var1,var2) (var1) / (var2)

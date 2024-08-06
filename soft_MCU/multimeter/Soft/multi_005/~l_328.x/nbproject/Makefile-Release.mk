#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-Release.mk)" "nbproject/Makefile-local-Release.mk"
include nbproject/Makefile-local-Release.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=Release
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../adc.c ../adt.c ../main.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1472/adc.o ${OBJECTDIR}/_ext/1472/adt.o ${OBJECTDIR}/_ext/1472/main.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1472/adc.o.d ${OBJECTDIR}/_ext/1472/adt.o.d ${OBJECTDIR}/_ext/1472/main.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1472/adc.o ${OBJECTDIR}/_ext/1472/adt.o ${OBJECTDIR}/_ext/1472/main.o

# Source Files
SOURCEFILES=../adc.c ../adt.c ../main.c

# Pack Options 
PACK_COMPILER_OPTIONS=-I "${DFP_DIR}/include"
PACK_COMMON_OPTIONS=-B "${DFP_DIR}/gcc/dev/atmega328p"



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-Release.mk dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=ATmega328P
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1472/adc.o: ../adc.c  .generated_files/95823b1545475bfa92155bc82294214623f56f66.flag .generated_files/4419dd11d8f1d4b0a243f0f00ee73d1277150bb1.flag
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/adc.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p  -I "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/include" -B "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/gcc/dev/atmega328p" -g -DDEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -gdwarf-2  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -DNDEBUG -DBOARD=ATMEGA328P_XPLAINED_MINI  -I "../src/ASF/common/boards" -I "../src/ASF/mega/utils/preprocessor" -I "../src/ASF/mega/utils" -I "../src/ASF/common/utils" -I "../src/ASF/mega/boards" -I "../src/ASF/mega/boards/atmega328p_xplained_mini" -I "../src/ASF/common/services/gpio" -I "../src/ASF/common/services/ioport" -I "../src" -I "../src/config" -Wall -MD -MP -MF "${OBJECTDIR}/_ext/1472/adc.o.d" -MT "${OBJECTDIR}/_ext/1472/adc.o.d" -MT ${OBJECTDIR}/_ext/1472/adc.o  -o ${OBJECTDIR}/_ext/1472/adc.o ../adc.c  -DXPRJ_Release=$(CND_CONF)  $(COMPARISON_BUILD)  -std=gnu99 -fno-strict-aliasing -Wstrict-prototypes -Wmissing-prototypes -Werror-implicit-function-declaration -Wpointer-arith -mrelax -fdata-sections
	
${OBJECTDIR}/_ext/1472/adt.o: ../adt.c  .generated_files/d7c58ff61bc2efc0ad3055d24a61758099fcadf.flag .generated_files/4419dd11d8f1d4b0a243f0f00ee73d1277150bb1.flag
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/adt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/adt.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p  -I "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/include" -B "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/gcc/dev/atmega328p" -g -DDEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -gdwarf-2  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -DNDEBUG -DBOARD=ATMEGA328P_XPLAINED_MINI  -I "../src/ASF/common/boards" -I "../src/ASF/mega/utils/preprocessor" -I "../src/ASF/mega/utils" -I "../src/ASF/common/utils" -I "../src/ASF/mega/boards" -I "../src/ASF/mega/boards/atmega328p_xplained_mini" -I "../src/ASF/common/services/gpio" -I "../src/ASF/common/services/ioport" -I "../src" -I "../src/config" -Wall -MD -MP -MF "${OBJECTDIR}/_ext/1472/adt.o.d" -MT "${OBJECTDIR}/_ext/1472/adt.o.d" -MT ${OBJECTDIR}/_ext/1472/adt.o  -o ${OBJECTDIR}/_ext/1472/adt.o ../adt.c  -DXPRJ_Release=$(CND_CONF)  $(COMPARISON_BUILD)  -std=gnu99 -fno-strict-aliasing -Wstrict-prototypes -Wmissing-prototypes -Werror-implicit-function-declaration -Wpointer-arith -mrelax -fdata-sections
	
${OBJECTDIR}/_ext/1472/main.o: ../main.c  .generated_files/95a565c81baf1170eb515b71720aee0e46f1ace4.flag .generated_files/4419dd11d8f1d4b0a243f0f00ee73d1277150bb1.flag
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p  -I "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/include" -B "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/gcc/dev/atmega328p" -g -DDEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -gdwarf-2  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -DNDEBUG -DBOARD=ATMEGA328P_XPLAINED_MINI  -I "../src/ASF/common/boards" -I "../src/ASF/mega/utils/preprocessor" -I "../src/ASF/mega/utils" -I "../src/ASF/common/utils" -I "../src/ASF/mega/boards" -I "../src/ASF/mega/boards/atmega328p_xplained_mini" -I "../src/ASF/common/services/gpio" -I "../src/ASF/common/services/ioport" -I "../src" -I "../src/config" -Wall -MD -MP -MF "${OBJECTDIR}/_ext/1472/main.o.d" -MT "${OBJECTDIR}/_ext/1472/main.o.d" -MT ${OBJECTDIR}/_ext/1472/main.o  -o ${OBJECTDIR}/_ext/1472/main.o ../main.c  -DXPRJ_Release=$(CND_CONF)  $(COMPARISON_BUILD)  -std=gnu99 -fno-strict-aliasing -Wstrict-prototypes -Wmissing-prototypes -Werror-implicit-function-declaration -Wpointer-arith -mrelax -fdata-sections
	
else
${OBJECTDIR}/_ext/1472/adc.o: ../adc.c  .generated_files/7d22c96abccf4a7b5b0a4123146a9acf4ee094a8.flag .generated_files/4419dd11d8f1d4b0a243f0f00ee73d1277150bb1.flag
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/adc.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p  -I "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/include" -B "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/gcc/dev/atmega328p"  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -DNDEBUG -DBOARD=ATMEGA328P_XPLAINED_MINI  -I "../src/ASF/common/boards" -I "../src/ASF/mega/utils/preprocessor" -I "../src/ASF/mega/utils" -I "../src/ASF/common/utils" -I "../src/ASF/mega/boards" -I "../src/ASF/mega/boards/atmega328p_xplained_mini" -I "../src/ASF/common/services/gpio" -I "../src/ASF/common/services/ioport" -I "../src" -I "../src/config" -Wall -MD -MP -MF "${OBJECTDIR}/_ext/1472/adc.o.d" -MT "${OBJECTDIR}/_ext/1472/adc.o.d" -MT ${OBJECTDIR}/_ext/1472/adc.o  -o ${OBJECTDIR}/_ext/1472/adc.o ../adc.c  -DXPRJ_Release=$(CND_CONF)  $(COMPARISON_BUILD)  -std=gnu99 -fno-strict-aliasing -Wstrict-prototypes -Wmissing-prototypes -Werror-implicit-function-declaration -Wpointer-arith -mrelax -fdata-sections
	
${OBJECTDIR}/_ext/1472/adt.o: ../adt.c  .generated_files/a4fdc4e21ccf78ead12288247cb3d471b1b78acb.flag .generated_files/4419dd11d8f1d4b0a243f0f00ee73d1277150bb1.flag
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/adt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/adt.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p  -I "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/include" -B "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/gcc/dev/atmega328p"  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -DNDEBUG -DBOARD=ATMEGA328P_XPLAINED_MINI  -I "../src/ASF/common/boards" -I "../src/ASF/mega/utils/preprocessor" -I "../src/ASF/mega/utils" -I "../src/ASF/common/utils" -I "../src/ASF/mega/boards" -I "../src/ASF/mega/boards/atmega328p_xplained_mini" -I "../src/ASF/common/services/gpio" -I "../src/ASF/common/services/ioport" -I "../src" -I "../src/config" -Wall -MD -MP -MF "${OBJECTDIR}/_ext/1472/adt.o.d" -MT "${OBJECTDIR}/_ext/1472/adt.o.d" -MT ${OBJECTDIR}/_ext/1472/adt.o  -o ${OBJECTDIR}/_ext/1472/adt.o ../adt.c  -DXPRJ_Release=$(CND_CONF)  $(COMPARISON_BUILD)  -std=gnu99 -fno-strict-aliasing -Wstrict-prototypes -Wmissing-prototypes -Werror-implicit-function-declaration -Wpointer-arith -mrelax -fdata-sections
	
${OBJECTDIR}/_ext/1472/main.o: ../main.c  .generated_files/df03bd7acee292605c0e79b8634ebc6199b1d25c.flag .generated_files/4419dd11d8f1d4b0a243f0f00ee73d1277150bb1.flag
	@${MKDIR} "${OBJECTDIR}/_ext/1472" 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1472/main.o 
	 ${MP_CC}  $(MP_EXTRA_CC_PRE) -mmcu=atmega328p  -I "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/include" -B "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/gcc/dev/atmega328p"  -x c -c -D__$(MP_PROCESSOR_OPTION)__  -Os -ffunction-sections -fdata-sections -fpack-struct -fshort-enums -DNDEBUG -DBOARD=ATMEGA328P_XPLAINED_MINI  -I "../src/ASF/common/boards" -I "../src/ASF/mega/utils/preprocessor" -I "../src/ASF/mega/utils" -I "../src/ASF/common/utils" -I "../src/ASF/mega/boards" -I "../src/ASF/mega/boards/atmega328p_xplained_mini" -I "../src/ASF/common/services/gpio" -I "../src/ASF/common/services/ioport" -I "../src" -I "../src/config" -Wall -MD -MP -MF "${OBJECTDIR}/_ext/1472/main.o.d" -MT "${OBJECTDIR}/_ext/1472/main.o.d" -MT ${OBJECTDIR}/_ext/1472/main.o  -o ${OBJECTDIR}/_ext/1472/main.o ../main.c  -DXPRJ_Release=$(CND_CONF)  $(COMPARISON_BUILD)  -std=gnu99 -fno-strict-aliasing -Wstrict-prototypes -Wmissing-prototypes -Werror-implicit-function-declaration -Wpointer-arith -mrelax -fdata-sections
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mmcu=atmega328p -B "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/gcc/dev/atmega328p"  -D__MPLAB_DEBUGGER_SIMULATOR=1 -gdwarf-2 -D__$(MP_PROCESSOR_OPTION)__  -Wl,-Map="dist\${CND_CONF}\${IMAGE_TYPE}\ol_328.X.${IMAGE_TYPE}.map"    -o dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}      -DXPRJ_Release=$(CND_CONF)  $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_SIMULATOR=1 -Wl,--gc-sections -Wl,--start-group  -Wl,-lm -Wl,-lm -Wl,--end-group  -Wl,--relax
	
	${MP_CC_DIR}\\avr-objcopy -j .eeprom --set-section-flags=.eeprom=alloc,load --change-section-lma .eeprom=0 --no-change-warnings -O ihex "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.eep" || exit 0
	${MP_CC_DIR}\\avr-objdump -h -S "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" > "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.lss"
	${MP_CC_DIR}\\avr-objcopy -O srec -R .eeprom -R .fuse -R .lock -R .signature "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.srec"
	
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -mmcu=atmega328p -B "C:/Program Files (x86)/Atmel/Studio/7.0/Packs/atmel/ATmega_DFP/1.2.150/gcc/dev/atmega328p"  -D__$(MP_PROCESSOR_OPTION)__  -Wl,-Map="dist\${CND_CONF}\${IMAGE_TYPE}\ol_328.X.${IMAGE_TYPE}.map"    -o dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}      -DXPRJ_Release=$(CND_CONF)  $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION) -Wl,--gc-sections -Wl,--start-group  -Wl,-lm -Wl,-lm -Wl,--end-group  -Wl,--relax
	${MP_CC_DIR}\\avr-objcopy -O ihex "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.hex"
	${MP_CC_DIR}\\avr-objcopy -j .eeprom --set-section-flags=.eeprom=alloc,load --change-section-lma .eeprom=0 --no-change-warnings -O ihex "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.eep" || exit 0
	${MP_CC_DIR}\\avr-objdump -h -S "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" > "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.lss"
	${MP_CC_DIR}\\avr-objcopy -O srec -R .eeprom -R .fuse -R .lock -R .signature "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX}" "dist/${CND_CONF}/${IMAGE_TYPE}/ol_328.X.${IMAGE_TYPE}.srec"
	
	
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/Release
	${RM} -r dist/Release

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif

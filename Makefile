# Environment variables
GCC_PATH:=$(MINGW64_32)

#---------------------------------------------------------------------
# Global directories
BIN_DIR:=Bin
OBJ_DIR:=$(BIN_DIR)/Obj

ifeq ($(ECHO),)
ECHO:=echo
endif

ifeq ($(MKDIR),)
MKDIR:= mkdir -p
endif
#---------------------------------------------------------------------
# Compiler base settings
GCC:= gcc
GCC_CMN:= $(GCC) -g -c -Wall -Wno-pointer-to-int-cast -Wno-int-to-pointer-cast -m32

CC:=$(GCC_CMN) -std=c99 -Werror=vla
CC_TESTS :=$(GCC_CMN) -std=gnu99 -Werror=vla
CC_CMOCKA:=$(GCC) -g -c -m32
#---------------------------------------------------------------------
# cmoka sources
CMOCKA_PATH:=tests/cmocka-1.1.5
cmocka_BIN:=$(BIN_DIR)/libcmocka.a
cmocka_OBJS:=$(OBJ_DIR)/$(CMOCKA_PATH)/src/cmocka.o
CMOCKA_INCS= -I $(CMOCKA_PATH)/include

$(cmocka_OBJS): $(OBJ_DIR)/%.o:%.c
	@${MKDIR} $(dir $@)
	@$(ECHO) Compiling $< to $@...
	@$(CC_CMOCKA) $< -o $@ $(CMOCKA_INCS)

#binary_tree sources
tree_INCS:= -I Binary_tree
tree_SRCS:= $(wildcard Binary_tree/*.c)
tree_OBJS:=$(addprefix $(OBJ_DIR)/,$(tree_SRCS:.c=.o))
tree_BIN:=$(BIN_DIR)/binary_tree.exe

#------------------------------------------------------------
#Unit tests sources
UT_INCS:= -I tests  $(CMOCKA_INCS) $(tree_INCS)
UT_FLAGS:= -D__TESTS -D__DETECT_CORRUPTION -D_CUSTOM_HEAP
UT_SRCS:= $(wildcard tests/*.c) $(tree_SRCS)
UT_OBJS:=$(addprefix $(OBJ_DIR)/,$(UT_SRCS:.c=.o))
UT_BIN:=$(BIN_DIR)/tests.exe

$(UT_OBJS): $(OBJ_DIR)/%.o:%.c
	@${MKDIR} $(dir $@)
	@$(ECHO) Compiling $< to $@...
	@$(CC) $(UT_FLAGS) $< -o $@ $(UT_INCS)

#------------------------------------------------------------
#Main sources
MAIN_INCS:= $(heap_INCS)
MAIN_FLAGS:= -D__DETECT_CORRUPTION
MAIN_SRCS:= $(wildcard *.c) $(tree_SRCS)
MAIN_OBJS:=$(addprefix $(OBJ_DIR)/main/,$(MAIN_SRCS:.c=.o))
MAIN_BIN:=$(BIN_DIR)/main.exe

$(MAIN_OBJS): $(OBJ_DIR)/main/%.o:%.c
	@${MKDIR} $(dir $@)
	@$(ECHO) Compiling $< to $@...
	@$(CC) $(MAIN_FLAGS) $< -o $@ $(MAIN_INCS)

.PHONY: aaa
aaa:
	@$(ECHO) $(UT_OBJS)
#------------------------------------------------------------------------------
#                        TARGET RULES
#------------------------------------------------------------------------------
.PHONY : help
help :
	@$(ECHO) "Summary of Makefile targets"
	@$(ECHO) "  Build targets:"
	@$(ECHO) "    unit_tests            		- Build Unit Tests"
	@$(ECHO) "  Clean targets:"
	@$(ECHO) "    clean_all         		 	- Clean local bin directory"

#------------------------------------------------------------
# cmocka
.PHONY: cmocka
cmocka_start:
	@$(ECHO) Building cmocka...

cmocka: cmocka_start $(cmocka_OBJS)
	@$(ECHO) Linking $(cmocka_BIN)...
	-ar rcs $(cmocka_BIN) $(cmocka_OBJS)

#------------------------------------------------------------
# Unit Tests
.PHONY: unit_tests
unit_tests_start:
	@$(ECHO) Building Framework unit tests...
	@$(ECHO) $(UT_OBJS)

unit_tests: cmocka unit_tests_start $(UT_OBJS)
	@$(ECHO) Linking $(UT_BIN)...
	@$(GCC) $(UT_OBJS) $(cmocka_BIN) -lm -m32 -o $(UT_BIN)

#------------------------------------------------------------
#main
#main_start:
#	@$(ECHO) Building main...

#main: main_start  $(MAIN_OBJS)
#	@$(ECHO) Linking $(MAIN_BIN)...
#	@$(GCC) -o $(MAIN_BIN) $(MAIN_OBJS) -lwinmm -lgdi32 -ldxguid -m32

#------------------------------------------------------------
# Clean all
.PHONY: clean_all
clean_all:
	@rm -rf $(BIN_DIR)
# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: iwillens <iwillens@student.42sp.org.br>    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/06/12 15:22:29 by iwillens          #+#    #+#              #
#    Updated: 2024/05/25 15:12:17 by iwillens         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
# *** Main Definitions                                                         #
# **************************************************************************** #

NAME = Sully

ASM = nasm
ASMFLAGS = -felf64 -g

SRC_DIR = ./
OBJ_DIR = ./build

SRCS = ${SRC_DIR}/Sully.s

OBJS = $(patsubst ${SRC_DIR}/%.s, ${OBJ_DIR}/%.o, ${SRCS})

# **************************************************************************** #
# *** Main Rules                                                               #
# **************************************************************************** #

all: ${NAME}

${NAME}: ${OBJS} Makefile
	@ld -o ${NAME} ${OBJS}
	@echo "\033[96m${NAME} is built. \033[0m"


${OBJ_DIR}/%.o: $(SRC_DIR)/%.s Makefile
	@mkdir -p ${@D}
	@${ASM} ${ASMFLAGS} -o $@ $<

# **************************************************************************** #
# *** Common Rules                                                             #
# **************************************************************************** #
clean:
	@rm -rf ${OBJ_DIR}

fclean: clean
	@rm -rf ./${NAME}

re: fclean all	

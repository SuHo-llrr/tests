if [[ -z $SPIKE_HOME  ]]; then
  echo "Please set \$SPIKE_HOME environment"
  exit 1
fi

if [[ -z $PK_HOME  ]]; then
  echo "Please set \$PK_HOME environment"
  exit 1
fi

echo "compile: "
echo "clang -trigraphs -fno-builtin -Wno-trigraphs -Wno-return-type -g -march=rv64gcv -stdlib=libc++ -static -fuse-ld=lld -D_LIBCPP_NO_LONG_DOUBLE -Wno-error=implicit-function-declaration -Wno-error=implicit-int -Wno-deprecated-non-prototype -DRUN_ON_SPIKE -march=rv64gcv_zicfiss0p4_zcmop0p2 -menable-experimental-extensions -Wl,-T -Wl,link64.ld -O1 --target=riscv64-unknown-linux-gnu -mcpu=generic-rv64 main.c -Wl,-z -Wl,force-zicfiss -Wl,-zforce-zicfilp -Wl,-Map=dump.txt"
clang -trigraphs -fno-builtin -Wno-trigraphs -Wno-return-type -g -march=rv64gcv -stdlib=libc++ -static -fuse-ld=lld -D_LIBCPP_NO_LONG_DOUBLE -Wno-error=implicit-function-declaration -Wno-error=implicit-int -Wno-deprecated-non-prototype -DRUN_ON_SPIKE -march=rv64gcv_zicfiss0p4_zcmop0p2 -menable-experimental-extensions -Wl,-T -Wl,link64.ld -O1 --target=riscv64-unknown-linux-gnu -mcpu=generic-rv64 main.c -Wl,-z -Wl,force-zicfiss -Wl,-zforce-zicfilp -Wl,-Map=dump.txt


echo "RUN Command: "
echo "$SPIKE_HOME/spike --isa=RV64IMAFDCV_zicntr_zihpm_zicfiss $PK_HOME/pk a.out"
$SPIKE_HOME/spike --isa=RV64IMAFDCV_zicntr_zihpm_zicfiss $PK_HOME/pk a.out






# Copyright lowRISC contributors.
# Licensed under the Apache License, Version 2.0, see LICENSE for details.
# SPDX-License-Identifier: Apache-2.0

# RISC-V linker parameters.
riscv_linker_script = '@0@/@1@'.format(meson.source_root(), files(['link.ld'])[0])
riscv_linker_args = [
  '-Wl,-T,@0@'.format(riscv_linker_script),
  # Depending on the compiler and its configuration (*), |--build-id| is passed
  # to the linker, causing the insertion of a ".note.gnu.build-id" section into
  # the ELF file. We do not use the build ID. Achieve consistent behavior and
  # potentially a small improvement in linking time by not computing the build
  # ID in the first place.
  #
  # * GCC built with |--enable-linker-build-id|, clang before 3.9 or built with
  #   |-DENABLE_LINKER_BUILD_ID|.
  '-Wl,--build-id=none',
]

# RISC-V startup library. Every RISC-V executable should depend on this target.
riscv_crt = declare_dependency(
  link_args: riscv_linker_args,
  # This is included as a source, not as a static library, so that the .crt
  # section is picked up correctly.
  sources: ['_crt.c'],
  dependencies: [sw_lib_irq, sw_lib_mem],
  # This argument exists solely so that Meson realizes that riscv_linker_script
  # is part of the dependency graph. This seems to be the only way to convince
  # Meson to behave in this way, for the following reasons:
  # - The dependencies arg can only include artifacts from declare_dependency().
  # - We can't put linker scripts into the sources list, since Meson has no
  #   clue how to deal with them.
  # - custom_target() doesn't help, because we can't convince Meson to depend on
  #   a custom_target() unless it produces source files.
  # - If we go with static_library, sources needs to be non-empty in order for
  #   Meson to correctly treat it as a cross-compile target (otherwise, we get
  #   linker errors). This is because Meson guesses the type of a target based
  #   off of the file extensions of the source files.
  link_with: static_library(
    'riscv_linker_script_dep_shim',
    sources: ['empty.c'],
    link_depends: [riscv_linker_script],
  )
)

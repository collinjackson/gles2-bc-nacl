CCFLAGS = \
	-I./chromium \
	-I./chromium/gpu \
	-I./chromium/third_party/gles2_book/Common/Include \
	-I./gles2-bc/Sources/OpenGLES \
	-I./gles2-bc/Sources/OpenGLES/OpenGLES20 \
	-DGL_GLEXT_PROTOTYPES \
	-DOPENGLES_DEBUG \
	-I. \
	-shared -lstdc++ -lobjc -m32 \

CHROMIUM_FILES = \
	chromium/ppapi/cpp/core.cc \
	chromium/ppapi/cpp/dev/context_3d_dev.cc \
        chromium/ppapi/cpp/dev/file_ref_dev.cc \
	chromium/ppapi/cpp/dev/graphics_3d_client_dev.cc \
	chromium/ppapi/cpp/dev/graphics_3d_dev.cc \
	chromium/ppapi/cpp/dev/surface_3d_dev.cc \
        chromium/ppapi/cpp/dev/scriptable_object_deprecated.cc \
	chromium/ppapi/cpp/instance.cc \
	chromium/ppapi/cpp/module.cc \
	chromium/ppapi/cpp/ppp_entrypoints.cc \
	chromium/ppapi/cpp/private/flash.cc \
	chromium/ppapi/cpp/private/flash_menu.cc \
	chromium/ppapi/cpp/rect.cc \
	chromium/ppapi/cpp/resource.cc \
        chromium/ppapi/cpp/url_loader.cc \
        chromium/ppapi/cpp/url_request_info.cc \
        chromium/ppapi/cpp/url_response_info.cc \
	chromium/ppapi/cpp/var.cc \
        chromium/ppapi/lib/gl/gles2/gl2ext_ppapi.c \
        chromium/ppapi/lib/gl/gles2/gles2.c \
	chromium/gpu/demos/framework/demo.cc \
	chromium/gpu/demos/framework/pepper.cc \
	chromium/third_party/gles2_book/Common/Source/esUtil.c \

GLES2_BC_FILES = \
        gles2-bc/Sources/OpenGLES/OpenGLES20/Attribute.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLES20/MatrixStack.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLES20/OpenGLES20Context.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLES20/OpenGLES20Implementation.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLES20/OpenGLESState.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLES20/Shader.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLES20/ShaderFile.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLES20/ShaderProgram.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLES20/ShaderSource.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLES20/Uniform.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLESConfig.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLESContext.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLESImplementation.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLESString.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLESUtil.cpp \
        gles2-bc/Sources/OpenGLES/OpenGLESFile.cpp \
        OpenGLES/ES2/stubs.c \

OUTPUT_TARGET = out/DemoES2

all:
	@echo Type \"make es1demo\" to show the ES1 demo. Type \"make es2demo\" to show the ES2 demo.

ES2_DEMO_FILES = \
	chromium/gpu/demos/gles2_book/demo_hello_triangle.cc \
	chromium/third_party/gles2_book/Chapter_2/Hello_Triangle/Hello_Triangle.c \
	chromium/third_party/gles2_book/Common/Source/esShader.c \

out/es2demo: $(CHROMIUM_FILES) $(HELLO_TRIANGLE_FILES)
	mkdir -p out
	gcc $(CHROMIUM_FILES) $(ES2_DEMO_FILES) $(CCFLAGS) -o $@

ES1_DEMO_FILES = \
	es1example.cpp \

out/es1demo: $(CHROMIUM_FILES) $(GLES2_BC_FILES) $(ES1_DEMO_FILES)
	mkdir -p out
	gcc $(CHROMIUM_FILES) $(GLES2_BC_FILES) $(ES1_DEMO_FILES) $(CCFLAGS) -o $@

TMP_CHROME_PROFILE ?= /tmp/chrome_profile

CHROME_FLAGS = --user-data-dir=$(TMP_CHROME_PROFILE) \
               --no-first-run --enable-accelerated-plugins --no-sandbox \
               chromium/gpu/demos/pepper_gpu_demo.html

ifeq ($(CHROME_PATH),)
%demo:
	@echo Please set the CHROME_PATH environment variable to point to a Chromium nightly
else
%demo: out/%demo
	$(CHROME_PATH) $(CHROME_FLAGS) --register-pepper-plugins="$(<);pepper-application/x-gpu-demo"
endif

clean:
	rm -rf out

.PHONY: all clean es1 es2
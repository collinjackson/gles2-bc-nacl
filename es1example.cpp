// Copyright (c) 2010 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// This is a simple example that draws a single triangle with
// a minimal vertex/fragment shader.  The purpose of this
// example is to demonstrate the basic concepts of
// OpenGL ES 2.0 rendering.

#include "gpu/demos/framework/demo_factory.h"
#include "gpu/demos/gles2_book/example.h"
#include "gles2-bc/Sources/OpenGLES/OpenGLES20/OpenGLES20Context.h"

#include <stdlib.h>

typedef struct
{
   OpenGLES::OpenGLESContext *gl;

} ES1ExampleUserData;

static int init ( ESContext *esContext )
{
    ES1ExampleUserData *userData = static_cast<ES1ExampleUserData*>(esContext->userData);
    userData->gl = new OpenGLES::OpenGLES2::OpenGLES20Context();
    OpenGLES::OpenGLESContext *gl = userData->gl;

    // Set up (optional)

    return TRUE;
}

static void draw ( ESContext *esContext )
{
    ES1ExampleUserData *userData = static_cast<ES1ExampleUserData*>(esContext->userData);
    OpenGLES::OpenGLESContext *gl = userData->gl;
    // Replace the implementation of this method to do your own custom drawing
    
    const GLfloat squareVertices[] = {
        -0.5f, -0.5f,
        0.5f,  -0.5f,
        -0.5f,  0.5f,
        0.5f,   0.5f,
    };
    const GLfloat squareColors[] = {
        1, 1, 0, 1,
        0, 1, 1, 1,
        0, 0, 0, 0,
        1, 0, 1, 1,
    };
    
    gl->glViewport(0, 0, esContext->width, esContext->height);

    // Are these necessary?
    // gl->glMatrixMode(GL_PROJECTION);
    // gl->glLoadIdentity();
    // gl->glOrthof(-1.0f, 1.0f, -1.5f, 1.5f, -1.0f, 1.0f);
    // gl->glMatrixMode(GL_MODELVIEW);
    // gl->glRotatef(3.0f, 0.0f, 0.0f, 1.0f);
    
    gl->glClearColor(0.5f, 0.5f, 0.5f, 1.0f);
    gl->glClear(GL_COLOR_BUFFER_BIT);
    
    gl->glVertexPointer(2, GL_FLOAT, 0, squareVertices);
    gl->glEnableClientState(GL_VERTEX_ARRAY);
    gl->glColorPointer(4, GL_FLOAT, 0, squareColors);
    gl->glEnableClientState(GL_COLOR_ARRAY);
    
    gl->glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
}

static void shutDown ( ESContext *esContext )
{
    ES1ExampleUserData *userData = static_cast<ES1ExampleUserData*>(esContext->userData);
    OpenGLES::OpenGLESContext *gl = userData->gl;

    // Clean up (optional)

}

namespace OpenGLES {

class ES1Example : public gpu::demos::gles2_book::Example<ES1ExampleUserData> {
 public:
  ES1Example() {
    RegisterCallbacks(init, NULL, draw, shutDown);
  }

  const wchar_t* Title() const {
    return L"ES1Example";
  }
};
}  // namespace OpenGLES

gpu::demos::Demo* gpu::demos::CreateDemo() {
  return new OpenGLES::ES1Example();
}
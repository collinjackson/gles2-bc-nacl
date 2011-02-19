// Copyright (c) 2011 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#ifndef PPAPI_C_PRIVATE_PROXY_PRIVATE_H_
#define PPAPI_C_PRIVATE_PROXY_PRIVATE_H_

#include "ppapi/c/pp_instance.h"
#include "ppapi/c/pp_module.h"
#include "ppapi/c/pp_resource.h"

#define PPB_PROXY_PRIVATE_INTERFACE "PPB_Proxy_Private;2"

// Exposes functions needed by the out-of-process proxy to call into the
// renderer PPAPI implementation.
struct PPB_Proxy_Private {
  // Called when the given plugin process has crashed.
  void (*PluginCrashed)(PP_Module module);

  // Returns the instance for the given resource, or 0 on failure.
  PP_Instance (*GetInstanceForResource)(PP_Resource resource);
};

#endif  // PPAPI_C_PRIVATE_PROXY_PRIVATE_H_

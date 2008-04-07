/* -*- Mode: C; tab-width: 8; indent-tabs-mode: nil; c-basic-offset: 4 -*-
 *
 * The contents of this file are subject to the Netscape Public
 * License Version 1.1 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy of
 * the License at http://www.mozilla.org/NPL/
 *
 * Software distributed under the License is distributed on an "AS
 * IS" basis, WITHOUT WARRANTY OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * The Original Code is mozilla.org code.
 *
 * The Initial Developer of the Original Code is Netscape
 * Communications Corporation.  Portions created by Netscape are
 * Copyright (C) 1999 Netscape Communications Corporation. All
 * Rights Reserved.
 *
 * Contributor(s): 
 */

/* Implement shared vtbl methods. */

#include "xptcprivate.h"

#if defined(sparc) || defined(__sparc__)

extern "C" nsresult
PrepareAndDispatch(nsXPTCStubBase* self, PRUint64 methodIndex, PRUint64* args)
{

#define PARAM_BUFFER_COUNT     16

    nsXPTCMiniVariant paramBuffer[PARAM_BUFFER_COUNT];
    nsXPTCMiniVariant* dispatchParams = NULL;
    nsIInterfaceInfo* iface_info = NULL;
    const nsXPTMethodInfo* info;
    PRUint8 paramCount;
    PRUint8 i;
    nsresult result = NS_ERROR_FAILURE;

    NS_ASSERTION(self,"no self");

    self->GetInterfaceInfo(&iface_info);
    NS_ASSERTION(iface_info,"no interface info");

    iface_info->GetMethodInfo(PRUint16(methodIndex), &info);
    NS_ASSERTION(info,"no interface info");

    paramCount = info->GetParamCount();

    // setup variant array pointer
    if(paramCount > PARAM_BUFFER_COUNT)
        dispatchParams = new nsXPTCMiniVariant[paramCount];
    else
        dispatchParams = paramBuffer;
    NS_ASSERTION(dispatchParams,"no place for params");

    PRUint64* ap = args;
    for(i = 0; i < paramCount; i++, ap++)
    {
        const nsXPTParamInfo& param = info->GetParam(i);
        const nsXPTType& type = param.GetType();
        nsXPTCMiniVariant* dp = &dispatchParams[i];

        if(param.IsOut() || !type.IsArithmetic())
        {
            dp->val.p = (void*) *ap;
            continue;
        }
        // else
        switch(type)
        {
        case nsXPTType::T_I8     : dp->val.i8  = *((PRInt32*)  ap);      break;
        case nsXPTType::T_I16    : dp->val.i16 = *((PRInt32*) ap);       break;
        case nsXPTType::T_I32    : dp->val.i32 = *((PRInt32*) ap);       break;
        case nsXPTType::T_DOUBLE : dp->val.d   = *((double*) ap);        break;
        case nsXPTType::T_U64    : dp->val.u64 = *((PRUint64*) ap);      break;
        case nsXPTType::T_I64    : dp->val.i64 = *((PRInt64*) ap);       break;
        case nsXPTType::T_U8     : dp->val.u8  = *((PRUint32*) ap);      break;
        case nsXPTType::T_U16    : dp->val.u16 = *((PRUint32*)ap);       break;
        case nsXPTType::T_U32    : dp->val.u32 = *((PRUint32*)ap);       break;
        case nsXPTType::T_FLOAT  : dp->val.f   = *((float*)   ap);       break;
        case nsXPTType::T_BOOL   : dp->val.b   = *((PRBool*)  ap);       break;
        case nsXPTType::T_CHAR   : dp->val.c   = *((PRUint32*) ap);      break;
        case nsXPTType::T_WCHAR  : dp->val.wc  = *((PRInt32*) ap);       break;
        default:
            NS_ASSERTION(0, "bad type");
            break;
        }
    }

    result = self->CallMethod((PRUint16)methodIndex, info, dispatchParams);

    NS_RELEASE(iface_info);

    if(dispatchParams != paramBuffer)
        delete [] dispatchParams;

    return result;
}

extern "C" int SharedStub(int, int*);

#define STUB_ENTRY(n) \
nsresult nsXPTCStubBase::Stub##n() \
{ \
	int dummy; /* defeat tail-call optimization */ \
	return SharedStub(n, &dummy); \
}

#define SENTINEL_ENTRY(n) \
nsresult nsXPTCStubBase::Sentinel##n() \
{ \
    NS_ASSERTION(0,"nsXPTCStubBase::Sentinel called"); \
    return NS_ERROR_NOT_IMPLEMENTED; \
}

#include "xptcstubsdef.inc"

#endif /* sparc || __sparc__ */

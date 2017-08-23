// Copyright (c) .NET Foundation. All rights reserved.
// Licensed under the Apache License, Version 2.0. See License.txt in the project root for license information.

using NuGet.Packaging.Core;

namespace KoreBuild.Tasks.Internal
{
    public class PackageInfo
    {
        public PackageIdentity Identity { get; set; }

        public string PackagePath { get; set; }

        public override string ToString()
        {
            return Identity.ToString();
        }
    }
}

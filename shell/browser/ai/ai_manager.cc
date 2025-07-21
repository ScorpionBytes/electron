// Copyright (c) 2025 Microsoft, Inc.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

#include "shell/browser/ai/ai_manager.h"

#include <utility>

#include "third_party/blink/public/mojom/ai/ai_common.mojom.h"
#include "third_party/blink/public/mojom/ai/ai_language_model.mojom.h"

namespace electron {

AIManager::AIManager() = default;

AIManager::~AIManager() = default;

void AIManager::AddReceiver(
    mojo::PendingReceiver<blink::mojom::AIManager> receiver) {
  receivers_.Add(this, std::move(receiver));
}

void AIManager::CanCreateLanguageModel(
    blink::mojom::AILanguageModelCreateOptionsPtr options,
    CanCreateLanguageModelCallback callback) {
  std::move(callback).Run(blink::mojom::ModelAvailabilityCheckResult::kUnavailableUnknown);
}

}  // namespace electron

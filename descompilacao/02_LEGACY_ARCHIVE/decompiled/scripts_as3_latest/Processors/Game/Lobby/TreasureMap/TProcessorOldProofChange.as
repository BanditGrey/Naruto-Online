package Processors.Game.Lobby.TreasureMap
{
   import Components.Slots.TUISlot;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Queries.TQueryString;
   import Foundation.Queries.Textures.TQueryAnimationSequence;
   import Foundation.Resources.Repositories.TResourceRepositoryTexture;
   import Foundation.Resources.SResourcesCore;
   import Foundation.Resources.Textures.TTexture;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Overlayers.TreasureMap.TTreasureProofChangTips;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TREASUREMAP;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorOldProofChange extends TProcessorLobbyWindow
   {
      
      public static const UPCOUNT:int = 10;
      
      public static const DOWNCOUNT:int = 6;
      
      public static const FOUR:int = 4;
      
      public static const FIVE:int = 5;
      
      protected var FPanel:MovieClip;
      
      private var FSprite:Sprite = new Sprite();
      
      protected var FurGodIndex:int = 1;
      
      protected var FAllGodIndex:int = 1;
      
      protected var FRightCount:int = 0;
      
      protected var UpVecLists:Vector.<TUISlot> = new Vector.<TUISlot>(UPCOUNT);
      
      protected var DownVecLists:Vector.<TUISlot> = new Vector.<TUISlot>(DOWNCOUNT);
      
      protected var VecInventorys:Vector.<TInventory> = new Vector.<TInventory>();
      
      protected var FAllVecObj:Vector.<Object>;
      
      protected var FBtnVec:Vector.<MovieClip> = new Vector.<MovieClip>(FOUR);
      
      protected var FProofCount:Vector.<uint> = new Vector.<uint>(FIVE);
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FTempSelectInventoriesId:Vector.<uint> = new Vector.<uint>();
      
      protected var FTempSelectInventoriesCount:Vector.<uint> = new Vector.<uint>();
      
      protected var F_0_1:Vector.<Object> = new Vector.<Object>();
      
      protected var FlashId:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      protected var FSelectInventories:TInventories = new TInventories();
      
      public var FUIWindowEditor:TUIWindowEditor;
      
      protected var ProofItems:Vector.<uint>;
      
      protected var FProofCountCopy:Vector.<uint> = new Vector.<uint>(FIVE);
      
      protected var FProofTip:TTreasureProofChangTips;
      
      protected var FRefleshNewProof:Function;
      
      protected var FIsCanExcel:int = 1;
      
      public function TProcessorOldProofChange(param1:TUIComponent)
      {
         this.VecInventorys.length = 0;
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_TREASUREMAP.RESOURCE_TREASUREMAP);
         super.ResourcesPerform_UIRequest();
      }
      
      public function BeginDraw() : void
      {
         this.FSprite.graphics.beginFill(0,0.3);
         this.FSprite.graphics.drawRect(0,0,FUICore.StageWidth,FUICore.StageHeight);
         this.FSprite.graphics.endFill();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_TREASUREMAP.RESOURCE_ClassName_MC_OldProofChange) as MovieClip;
         addChild(this.FSprite);
         this.BeginDraw();
         this.FSprite.addChild(this.FPanel);
         this.FSprite.x = FUICore.StageWidth - this.FSprite.width >> 1;
         this.FSprite.y = FUICore.StageHeight - this.FSprite.height >> 1;
         this.FPanel.x = this.FSprite.width - this.FPanel.width >> 1;
         this.FPanel.y = this.FSprite.height - this.FPanel.height >> 1;
         this.AddEventListener();
         this.SetCompent();
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         super.ResourcesPerform_UILocations();
      }
      
      protected function AddEventListener() : void
      {
         this.FPanel.BT_Close.addEventListener(MouseEvent.CLICK,this.BtnClick);
      }
      
      protected function SetCompent() : void
      {
         var _loc2_:TUISlot = null;
         var _loc1_:int = 0;
         while(_loc1_ < UPCOUNT)
         {
            _loc2_ = new TUISlot(this);
            _loc2_.Resource = this.FPanel["MC_Slot_" + _loc1_] as MovieClip;
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.Tag = _loc1_;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.OnOverlay = this.UIComponentsHintOnOver;
            _loc2_.OnOut = this.UIComponentsHintOnOut;
            _loc2_.OnClick = this.UIComponentHintClick;
            _loc2_.Init();
            this.UpVecLists[_loc1_] = _loc2_;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < DOWNCOUNT)
         {
            _loc2_ = new TUISlot(this);
            _loc2_.Resource = this.FPanel["MC_Slot_0" + _loc1_] as MovieClip;
            _loc2_.MCDefaultIcon = TUtilityReflection.CreateDisplayObjectInstance(CONST_COMMON.RESOURCE_ClassName_MC_ItemIconLoaderStyle) as MovieClip;
            _loc2_.Tag = _loc1_;
            _loc2_.OnQuerySequenceContext = this.SlotsOnQuerySequenceContext;
            _loc2_.OnQuerySubscript = this.SlotsOnQuerySubscript;
            _loc2_.OnOverlay = this.UIComponentsHintOnOver;
            _loc2_.OnOut = this.UIComponentsHintOnOut;
            _loc2_.OnClick = this.UIComponentHint;
            _loc2_.Init();
            this.DownVecLists[_loc1_] = _loc2_;
            _loc1_++;
         }
         this.FBtnVec.length = 0;
         this.FBtnVec.push(this.FPanel["mc_page"]["MC_PageLeft"],this.FPanel["mc_page"]["MC_PageRight"],this.FPanel["mc_clear_btn"],this.FPanel["mc_change_btn"]);
         _loc1_ = 0;
         while(_loc1_ < FOUR)
         {
            TGameUtil.setButtonMode(this.FBtnVec[_loc1_],true);
            this.FBtnVec[_loc1_].addEventListener(MouseEvent.CLICK,this.BtnClickfour);
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            MovieClip(this.FPanel["mc_proof_" + _loc1_]).addEventListener(MouseEvent.MOUSE_OVER,this.COver);
            MovieClip(this.FPanel["mc_proof_" + _loc1_]).addEventListener(MouseEvent.MOUSE_OUT,this.COUT);
            MovieClip(this.FPanel["mc_proof_" + _loc1_]).addEventListener(MouseEvent.MOUSE_MOVE,this.CMOVE);
            MovieClip(this.FPanel["mc_proof_" + _loc1_]["MC_Color"]).gotoAndStop(FIVE - _loc1_);
            _loc1_++;
         }
         this.FOverlayerAppliance = new TOverlayerAppliance(FParent,CONST_MODULES.MODULE_TreasureMap);
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         this.FUIWindowEditor = new TUIWindowEditor(FParent,CONST_MODULES.MODULE_TreasureMap);
         this.FUIWindowEditor.OnOK = this.WindowEditorOnOK;
         this.FUIWindowEditor.OnMax = this.WindowEditorOnMax;
         this.FUIWindowEditor.x = (CONST_COMMON.STAGE_Width - this.FUIWindowEditor.WindowWidth) / 2;
         this.FUIWindowEditor.y = (CONST_COMMON.STAGE_Height - this.FUIWindowEditor.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowEditor(this.FUIWindowEditor);
         this.FProofTip = new TTreasureProofChangTips(FParent);
         this.FProofTip.visible = false;
         this.FProofTip.mouseEnabled = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FProofTip);
      }
      
      public function COver(param1:MouseEvent) : void
      {
         var _loc2_:String = param1.currentTarget.name;
         var _loc3_:int = int(_loc2_.charAt(Number(_loc2_.length - 1)));
         this.FProofTip.Context = this.ProofItems[_loc3_];
         this.FProofTip.Render(FUICore.MouseCoordinate);
         this.FProofTip.Show();
      }
      
      public function COUT(param1:MouseEvent) : void
      {
         this.FProofTip.Hide();
      }
      
      public function CMOVE(param1:MouseEvent) : void
      {
         this.FProofTip.Render(FUICore.MouseCoordinate);
      }
      
      public function updatecell() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < this.UpVecLists.length)
         {
            this.UpVecLists[_loc1_].Update();
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.DownVecLists.length)
         {
            this.DownVecLists[_loc1_].Update();
            _loc1_++;
         }
         if(this.FUIWindowEditor != null)
         {
            this.FUIWindowEditor.Update();
         }
      }
      
      public function BtnClick(param1:MouseEvent) : void
      {
         this.visible = false;
         this.ClearBtn();
         this.FRefleshNewProof();
      }
      
      public function set RefleshNewProof(param1:Function) : void
      {
         this.FRefleshNewProof = param1;
      }
      
      public function OpenMe(param1:Vector.<Object>, param2:Vector.<uint>) : void
      {
         this.FAllVecObj = param1;
         this.ProofItems = param2;
         this.godrelation();
         this.FSelectInventories.Clear();
         this.GodSlotRight(this.FSelectInventories);
         this.RefreshProofCount();
         this.clearAddText();
         this.TwoSmallBell();
      }
      
      protected function TwoSmallBell() : void
      {
         MovieClip(this.FPanel["MC_Left"]).gotoAndPlay(1);
         MovieClip(this.FPanel["MC_Right"]).gotoAndPlay(1);
      }
      
      public function ChangeSucceed() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.FlashId.length)
         {
            MovieClip(this.FlashId[_loc1_]["MC_movie"]).gotoAndPlay(1);
            _loc1_++;
         }
         this.FlashId.length = 0;
         this.godrelation();
         this.RefreshProofCount();
         this.clearAddText();
      }
      
      protected function godrelation() : void
      {
         var _loc3_:TInventory = null;
         var _loc5_:int = 0;
         this.VecInventorys.length = 0;
         var _loc1_:int = 0;
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         var _loc4_:int = _loc2_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = _loc2_.GetInventoryByIndex(_loc1_);
            if(_loc3_.CategorySecond == 200)
            {
               _loc5_ = 0;
               while(_loc5_ < this.FAllVecObj.length)
               {
                  if(_loc3_.IDTemplate == this.FAllVecObj[_loc5_].fr_itemid)
                  {
                     this.VecInventorys.push(_loc3_);
                  }
                  _loc5_++;
               }
            }
            _loc1_++;
         }
         this.god_slot();
      }
      
      protected function god_slot() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Number = Number(this.VecInventorys.length);
         this.FAllGodIndex = Math.ceil(_loc2_ / UPCOUNT);
         if(this.FAllGodIndex == 0)
         {
            this.FAllGodIndex = 1;
         }
         _loc1_ = 0;
         while(_loc1_ < UPCOUNT)
         {
            _loc3_ = _loc1_ + (this.FurGodIndex - 1) * UPCOUNT;
            if(_loc3_ > _loc2_ - 1)
            {
               this.UpVecLists[_loc1_].Context = null;
            }
            else
            {
               this.UpVecLists[_loc1_].Context = this.VecInventorys[_loc3_];
            }
            _loc1_++;
         }
         this.reflshFilter();
         this.setBtnState2();
      }
      
      protected function reflshFilter() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:TInventory = null;
         var _loc1_:Number = Number(this.VecInventorys.length);
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < UPCOUNT)
         {
            _loc3_ = _loc2_ + (this.FurGodIndex - 1) * UPCOUNT;
            if(_loc3_ <= _loc1_ - 1)
            {
               _loc4_ = this.UpVecLists[_loc2_].Context as TInventory;
               if(_loc4_.Quantity <= 0)
               {
                  this.UpVecLists[_loc2_].SetDefaultFilters(true);
               }
               else
               {
                  this.UpVecLists[_loc2_].SetDefaultFilters(false);
               }
            }
            _loc2_++;
         }
      }
      
      public function BtnClickfour(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FPanel["mc_page"]["MC_PageLeft"]:
               if(this.FurGodIndex > 1)
               {
                  --this.FurGodIndex;
                  this.god_slot();
               }
               break;
            case this.FPanel["mc_page"]["MC_PageRight"]:
               if(this.FurGodIndex < this.FAllGodIndex)
               {
                  this.FurGodIndex += 1;
                  this.god_slot();
               }
               break;
            case this.FPanel["mc_clear_btn"]:
               this.ClearBtn();
               break;
            case this.FPanel["mc_change_btn"]:
               this.SendMesS_c();
         }
      }
      
      protected function SendMesS_c() : void
      {
         var _loc1_:TPacket = null;
         var _loc2_:ByteArray = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TreasureMap_OldProof);
         _loc2_ = _loc1_.Data;
         _loc2_.writeShort(this.FSelectInventories.Count);
         var _loc3_:int = 0;
         while(_loc3_ < this.FSelectInventories.Count)
         {
            _loc2_.writeUnsignedInt(this.FSelectInventories.GetInventoryByIndex(_loc3_).IDTemplate);
            _loc2_.writeUnsignedInt(this.FSelectInventories.GetInventoryByIndex(_loc3_).Quantity);
            _loc3_++;
         }
         this.ClearBtn();
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function setBtnState2() : void
      {
         if(this.FAllGodIndex <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FPanel["mc_page"]["MC_PageLeft"]),false);
            TGameUtil.setButtonMode(MovieClip(this.FPanel["mc_page"]["MC_PageRight"]),false);
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FPanel["mc_page"]["MC_PageLeft"]),this.FurGodIndex == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FPanel["mc_page"]["MC_PageRight"]),this.FurGodIndex >= this.FAllGodIndex ? false : true);
         }
         if(this.FurGodIndex > this.FAllGodIndex)
         {
            this.FurGodIndex = this.FAllGodIndex;
         }
         TextField(this.FPanel["mc_page"]["page"]).text = this.FurGodIndex + "/" + this.FAllGodIndex;
      }
      
      protected function UIComponentHint(param1:Object, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc4_:TInventory = param2 as TInventory;
         var _loc5_:String = param1.Resource.name;
         var _loc6_:int = int(_loc5_.charAt(_loc5_.length - 1));
         _loc3_ = 0;
         while(_loc3_ < this.VecInventorys.length)
         {
            if(this.VecInventorys[_loc3_].Identifier1 == this.F_0_1[_loc6_].Identifier1 && this.VecInventorys[_loc3_].Identifier0 == this.F_0_1[_loc6_].Identifier0)
            {
               this.VecInventorys[_loc3_].Quantity += _loc4_.Quantity;
               break;
            }
            _loc3_++;
         }
         this.FTempSelectInventoriesId.splice(_loc6_,1);
         this.FTempSelectInventoriesCount.splice(_loc6_,1);
         this.F_0_1.splice(_loc6_,1);
         this.FSelectInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         this.GodSlotRight(this.FSelectInventories);
         if(this.FOverlayerAppliance)
         {
            this.FOverlayerAppliance.Hide();
         }
         this.ReadTextedminus(_loc4_);
      }
      
      protected function UIComponentHintClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = param2 as TInventory;
         var _loc4_:int = 0;
         if(_loc3_.Quantity == 0)
         {
            return;
         }
         if(this.FRightCount >= DOWNCOUNT)
         {
            EffectGenerateText(STRING_INHERITPRACTICE.INHERIT_FORTION03);
            return;
         }
         if(_loc3_.Quantity > 99)
         {
            _loc4_ = 99;
         }
         else
         {
            _loc4_ = int(_loc3_.Quantity);
         }
         var _loc5_:int = 0;
         while(_loc5_ < this.FTempSelectInventoriesId.length)
         {
            if(this.F_0_1[_loc5_].Identifier1 == _loc3_.Identifier1 && this.F_0_1[_loc5_].Identifier0 == _loc3_.Identifier0)
            {
               if(this.FTempSelectInventoriesCount[_loc5_] == 99)
               {
                  return;
               }
               if(this.FTempSelectInventoriesCount[_loc5_] + _loc4_ > 90)
               {
                  _loc4_ = 99 - this.FTempSelectInventoriesCount[_loc5_];
               }
            }
            _loc5_++;
         }
         this.FUIWindowEditor.Context = _loc3_;
         this.FUIWindowEditor.Label = _loc3_.Name;
         this.FUIWindowEditor.Quantity = String(_loc4_);
         this.FUIWindowEditor.Value = _loc4_;
         this.FUIWindowEditor.Max = _loc4_;
         this.FUIWindowEditor.Min = 1;
         this.FUIWindowEditor.visible = true;
      }
      
      public function WindowEditorOnMax(param1:TUIWindowEditor) : void
      {
         param1.Value = param1.Max;
      }
      
      public function WindowEditorOnOK(param1:TUIWindowEditor) : void
      {
         var _loc3_:TInventory = null;
         var _loc2_:int = 0;
         var _loc4_:Boolean = true;
         var _loc5_:TInventory = param1.Context as TInventory;
         if(param1.Value <= _loc5_.Quantity)
         {
            _loc5_.Quantity -= param1.Value;
         }
         while(_loc2_ < this.FTempSelectInventoriesId.length)
         {
            if(this.F_0_1[_loc2_].Identifier1 == _loc5_.Identifier1 && this.F_0_1[_loc2_].Identifier0 == _loc5_.Identifier0)
            {
               this.FTempSelectInventoriesCount[_loc2_] += param1.Value;
               _loc4_ = false;
            }
            _loc2_++;
         }
         if(_loc4_)
         {
            this.FTempSelectInventoriesId.push(_loc5_.IDTemplate);
            this.FTempSelectInventoriesCount.push(param1.Value);
            this.F_0_1.push({
               "Identifier1":_loc5_.Identifier1,
               "Identifier0":_loc5_.Identifier0
            });
         }
         this.FSelectInventories.Clear();
         this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FSelectInventories,this.FTempSelectInventoriesId);
         this.GodSlotRight(this.FSelectInventories);
         this.ReadTextedadd();
      }
      
      protected function GodSlotRight(param1:TInventories) : void
      {
         var _loc3_:TInventory = null;
         this.FRightCount = param1.Count;
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            if(_loc2_ >= this.FRightCount)
            {
               this.DownVecLists[_loc2_].Context = null;
            }
            else
            {
               _loc3_ = param1.GetInventoryByIndex(_loc2_);
               _loc3_.Quantity = this.FTempSelectInventoriesCount[_loc2_];
               this.DownVecLists[_loc2_].Context = _loc3_;
            }
            _loc2_++;
         }
         this.reflshFilter();
      }
      
      protected function SlotsOnQuerySequenceContext(param1:Object, param2:Object, param3:TQueryAnimationSequence, param4:uint = 0) : void
      {
         var _loc5_:TInventory = null;
         var _loc6_:TResourceRepositoryTexture = null;
         var _loc7_:TTexture = null;
         _loc5_ = param2 as TInventory;
         _loc6_ = SResourcesCore.TexturesInventory;
         _loc7_ = _loc6_.GetTextureByIdentifier(_loc5_.IDTexture);
         if(_loc7_ != null)
         {
            param3.Value = _loc7_.GetAnimationSequenceByIdentifier(param4);
         }
         else
         {
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_TreasureMap);
         }
      }
      
      protected function UIComponentsHintOnOver(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Context = _loc3_;
            _loc4_.Render(FUICore.MouseCoordinate);
            _loc4_.Show();
         }
      }
      
      protected function UIComponentsHintOnOut(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:TOverlayer = null;
         _loc3_ = param2 as TInventory;
         _loc4_ = this.FOverlayerAppliance;
         if(_loc4_ != null)
         {
            _loc4_.Hide();
         }
      }
      
      protected function SlotsOnQuerySubscript(param1:Object, param2:Object, param3:TQueryString) : void
      {
         var _loc4_:TAppliance = null;
         if(param2 is TAppliance)
         {
            _loc4_ = param2 as TAppliance;
            param3.Value = _loc4_.Quantity.toString();
         }
      }
      
      public function ClearBtn() : void
      {
         this.FIsCanExcel = 0;
         while(this.FSelectInventories.Count)
         {
            this.UIComponentHint(this.DownVecLists[0],this.FSelectInventories.GetInventoryByIndex(0));
         }
         this.FIsCanExcel = 1;
      }
      
      protected function RefreshProofCount() : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         while(_loc1_ < this.FProofCount.length)
         {
            this.FProofCount[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < _loc2_.Count)
         {
            _loc3_ = _loc2_.GetInventoryByIndex(_loc1_);
            _loc4_ = 0;
            while(_loc4_ < this.ProofItems.length)
            {
               if(_loc3_.IDTemplate == this.ProofItems[_loc4_])
               {
                  if(this.FProofCount[_loc4_] == 0)
                  {
                     this.FProofCount[_loc4_] = _loc3_.Quantity;
                  }
                  else
                  {
                     this.FProofCount[_loc4_] += _loc3_.Quantity;
                  }
               }
               _loc4_++;
            }
            _loc1_++;
         }
         this.ReadText();
      }
      
      protected function ReadText() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < FIVE)
         {
            TextField(this.FPanel["mc_proof_" + _loc1_]["MC_movie"]["MC_movie_two"]["TF_Count"]).text = String(this.FProofCount[_loc1_]);
            _loc1_++;
         }
      }
      
      protected function ReadTextedminus(param1:TInventory) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.FAllVecObj.length)
         {
            if(this.FAllVecObj[_loc2_].fr_itemid == param1.IDTemplate)
            {
               _loc3_ = 0;
               while(_loc3_ < this.ProofItems.length)
               {
                  if(this.ProofItems[_loc3_] == uint(this.FAllVecObj[_loc2_].to_itemid))
                  {
                     if(this.FProofCountCopy[_loc3_] == 0)
                     {
                        return;
                     }
                     this.FProofCountCopy[_loc3_] -= uint(this.FAllVecObj[_loc2_].to_itemcnt) * param1.Quantity;
                  }
                  _loc3_++;
               }
            }
            _loc2_++;
         }
         this.clearAddText();
      }
      
      protected function ReadTextedadd() : void
      {
         var _loc2_:TInventory = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < FIVE)
         {
            this.FProofCountCopy[_loc1_] = 0;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < this.FSelectInventories.Count)
         {
            _loc2_ = this.FSelectInventories.GetInventoryByIndex(_loc1_);
            _loc3_ = 0;
            while(_loc3_ < this.FAllVecObj.length)
            {
               if(_loc2_.IDTemplate == this.FAllVecObj[_loc3_].fr_itemid)
               {
                  _loc4_ = 0;
                  while(_loc4_ < this.ProofItems.length)
                  {
                     if(uint(this.FAllVecObj[_loc3_].to_itemid) == this.ProofItems[_loc4_])
                     {
                        if(this.FProofCountCopy[_loc4_] == 0)
                        {
                           this.FProofCountCopy[_loc4_] = uint(this.FAllVecObj[_loc3_].to_itemcnt) * _loc2_.Quantity;
                        }
                        else
                        {
                           this.FProofCountCopy[_loc4_] += uint(this.FAllVecObj[_loc3_].to_itemcnt) * _loc2_.Quantity;
                        }
                        break;
                     }
                     _loc4_++;
                  }
               }
               _loc3_++;
            }
            _loc1_++;
         }
         this.clearAddText();
      }
      
      public function clearAddText() : void
      {
         if(this.FIsCanExcel)
         {
            this.FlashId.length = 0;
         }
         var _loc1_:int = 0;
         while(_loc1_ < FIVE)
         {
            if(this.FProofCountCopy[_loc1_] == 0)
            {
               TextField(this.FPanel["mc_proof_" + _loc1_]["TF_Counted"]).text = "";
            }
            else
            {
               TextField(this.FPanel["mc_proof_" + _loc1_]["TF_Counted"]).text = "+" + this.FProofCountCopy[_loc1_];
               if(this.FIsCanExcel)
               {
                  this.FlashId.push(this.FPanel["mc_proof_" + _loc1_]);
               }
            }
            _loc1_++;
         }
      }
   }
}


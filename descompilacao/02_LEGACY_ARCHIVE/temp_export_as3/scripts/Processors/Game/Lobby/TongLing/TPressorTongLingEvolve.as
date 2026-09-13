package Processors.Game.Lobby.TongLing
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
   import Foundation.UI.TUICore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TBB_EvoPoint;
   import Logics.DatebaseVO.VO.TBB_LuckyCard;
   import Logics.DatebaseVO.VO.TBB_Status;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.Inventories.TAppliance;
   import Logics.Inventories.TInventories;
   import Logics.Inventories.TInventory;
   import Logics.SLogicsCore;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Lobby.TongLing.ToolS.TProcessorPathPic;
   import Processors.Game.Lobby.TongLing.ToolS.TProcessorShopJinHua;
   import Processors.Game.Lobby.TongLing.ToolS.jinhuaCellFour;
   import Processors.Game.Windows.Editors.TUIWindowEditor;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.Inventories.TOverlayerAppliance;
   import Rendering.Overlayers.TOverlayer;
   import Rendering.Overlayers.TongLingAnimal.TongLingAttriteTip;
   import Rendering.Overlayers.TongLingAnimal.TongLingIntroTip;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_TONGLINGANIMAL;
   import Resources.Strings.STRING_INHERITPRACTICE;
   import Resources.Strings.STRING_TONGLING;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TPressorTongLingEvolve extends TProcessorLobbyWindow
   {
      
      public static const UPCOUNT:int = 6;
      
      public static const DOWNCOUNT:int = 3;
      
      public static const JIANHUACOUNT:int = 4;
      
      protected static const QUALITYCOLOR_INDEX:Vector.<uint> = CONST_COMMON.QUALITYCOLOR_INDEX;
      
      public static var ISUPDATE:int = 0;
      
      protected var FRootPanle:MovieClip;
      
      protected var FMvcShop:TProcessorShopJinHua;
      
      protected var FMvcPath:TProcessorPathPic;
      
      protected var UpVecLists:Vector.<TUISlot> = new Vector.<TUISlot>(UPCOUNT);
      
      protected var DownVecLists:Vector.<TUISlot> = new Vector.<TUISlot>(DOWNCOUNT);
      
      protected var VecInventorys:Vector.<TInventory> = new Vector.<TInventory>();
      
      protected var FDataObj:Object = null;
      
      protected var FHeadBmp:Bitmap = new Bitmap();
      
      protected var FStatus:TBB_Status;
      
      protected var FAllJinHua:int;
      
      protected var FallJinHua:TextField;
      
      protected var FthisJinHua:TextField;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
      
      public var FUIWindowEditor:TUIWindowEditor;
      
      protected var FTempSelectInventoriesId:Vector.<uint> = new Vector.<uint>();
      
      protected var FTempSelectInventoriesCount:Vector.<uint> = new Vector.<uint>();
      
      protected var F_0_1:Vector.<Object> = new Vector.<Object>();
      
      protected var FSelectInventories:TInventories = new TInventories();
      
      protected var FurGodIndex:int = 1;
      
      protected var FAllGodIndex:int = 1;
      
      protected var FRightCount:int = 0;
      
      protected var VecFours:Vector.<jinhuaCellFour> = new Vector.<jinhuaCellFour>(4);
      
      protected var AtrConditions:Vector.<Object>;
      
      protected var VecFourText:Vector.<TextField> = new Vector.<TextField>();
      
      protected var FDownCount:int;
      
      protected var FCanChangeArr:Array;
      
      protected var FShoeArr:Array = new Array();
      
      protected var FUcore:TUICore;
      
      protected var FOverlayerAppliance:TOverlayerAppliance;
      
      protected var FTipShop:TongLingAttriteTip;
      
      protected var FPerCompoent:TUIComponent;
      
      protected var FIsUpdate:int = 1;
      
      protected var FIntroTip:TongLingIntroTip;
      
      protected var TPopWindow:TUIWindowConfirmation;
      
      protected var FExteShow:Function;
      
      protected var FOpenShop:Function;
      
      public function TPressorTongLingEvolve(param1:TUIComponent, param2:TProcessorShopJinHua, param3:TProcessorPathPic, param4:TUICore)
      {
         this.FMvcShop = param2;
         this.FMvcPath = param3;
         this.FUcore = param4;
         this.FPerCompoent = param1;
         this.VecInventorys.length = 0;
         super(param1);
      }
      
      public function setMovi(param1:MovieClip) : void
      {
         this.FRootPanle = param1;
         this.SetValue();
      }
      
      public function SetMsg(param1:Object) : void
      {
         var _loc2_:int = 0;
         this.FDataObj = param1;
         if(param1 == null)
         {
            TextField(this.FRootPanle["MC_name"]["TF_Text"]).text = "";
            this.FthisJinHua.text = "";
            TextField(this.FRootPanle["tt_00"]).text = "";
            TextField(this.FRootPanle["tt_01"]).text = "";
            TextField(this.FRootPanle["tt_02"]).text = "";
            TextField(this.FRootPanle["tt_03"]).text = "";
            this.FHeadBmp.bitmapData = null;
            _loc2_ = 0;
            while(_loc2_ < JIANHUACOUNT)
            {
               this.VecFours[_loc2_].setBitNull();
               _loc2_++;
            }
            return;
         }
         this.setName(param1);
      }
      
      public function OpenMe() : void
      {
         this.godrelation();
         this.FSelectInventories.Clear();
         this.GodSlotRight(this.FSelectInventories);
      }
      
      public function InitiaEditor(param1:TUIComponent) : void
      {
         var _loc2_:TConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.TongLing_jilv) as TConfigValue;
         this.AtrConditions = _loc2_.Value as Vector.<Object>;
         super.ResourcesPerform_UILocations();
      }
      
      public function WindowEditorOnCancel(param1:TUIWindowEditor) : void
      {
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
      }
      
      protected function GodSlotRight(param1:TInventories) : void
      {
         var _loc3_:TInventory = null;
         this.FRightCount = param1.Count;
         var _loc2_:int = 0;
         while(_loc2_ < 3)
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
         if(this.FDataObj == null)
         {
            this.reflshFilter();
            return;
         }
         this.JinHuaShow(this.FDataObj.Id);
      }
      
      public function initiOpen() : void
      {
         this.F_0_1.length = 0;
         this.FTempSelectInventoriesId.length = 0;
         this.FTempSelectInventoriesCount.length = 0;
      }
      
      public function setName(param1:Object) : void
      {
         if(param1 != null)
         {
            this.FStatus = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,param1.Id) as TBB_Status;
            TextField(this.FRootPanle["MC_name"]["TF_Text"]).text = this.FStatus.Name;
            this.JinHuaShow(param1.Id);
         }
      }
      
      public function BtnreelClick(param1:MouseEvent) : void
      {
         this.FOpenShop();
      }
      
      public function set OpenShop(param1:Function) : void
      {
         this.FOpenShop = param1;
      }
      
      public function BtnPathClick(param1:MouseEvent) : void
      {
         TProcessorPathPic.ISUPDATE = 1;
         this.FMvcPath.visible = true;
      }
      
      public function BtnClick(param1:MouseEvent) : void
      {
         this.FMvcShop.Visible = true;
      }
      
      protected function godrelation() : void
      {
         var _loc3_:TInventory = null;
         this.VecInventorys.length = 0;
         var _loc1_:int = 0;
         var _loc2_:TInventories = SLogicsCore.Character.Appliances;
         var _loc4_:int = _loc2_.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc4_)
         {
            _loc3_ = _loc2_.GetInventoryByIndex(_loc1_);
            if(_loc3_.CategorySecond == 105)
            {
               this.VecInventorys.push(_loc3_);
            }
            _loc1_++;
         }
         this.god_slot();
      }
      
      public function selClick(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case this.FRootPanle["btn_left"]:
               if(this.FurGodIndex > 1)
               {
                  --this.FurGodIndex;
                  this.god_slot();
               }
               break;
            case this.FRootPanle["btn_right"]:
               if(this.FurGodIndex < this.FAllGodIndex)
               {
                  this.FurGodIndex += 1;
                  this.god_slot();
               }
         }
      }
      
      protected function god_slot() : void
      {
         var _loc3_:TInventory = null;
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = int(this.VecInventorys.length);
         this.FAllGodIndex = Math.ceil(_loc2_ / UPCOUNT);
         _loc1_ = 0;
         while(_loc1_ < UPCOUNT)
         {
            _loc4_ = _loc1_ + (this.FurGodIndex - 1) * UPCOUNT;
            if(_loc4_ > _loc2_ - 1)
            {
               this.UpVecLists[_loc1_].Context = null;
            }
            else
            {
               _loc3_ = this.VecInventorys[_loc4_];
               this.UpVecLists[_loc1_].Context = _loc3_;
            }
            _loc1_++;
         }
         this.reflshFilter();
         this.setBtnState2();
      }
      
      public function GetBooBelIsFilters(param1:TInventory) : Boolean
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TBB_LuckyCard = null;
         var _loc5_:Array = null;
         _loc2_ = 0;
         while(_loc2_ < this.VecFours.length)
         {
            if(this.VecFours[_loc2_].CurRarity != 77)
            {
               _loc4_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_LuckyCard,param1.IDTemplate) as TBB_LuckyCard;
               _loc5_ = this.getStr(_loc4_.EvoRate);
               _loc3_ = 0;
               while(_loc3_ < _loc5_.length)
               {
                  if(this.VecFours[_loc2_].CurRarity == _loc5_[_loc3_][1])
                  {
                     return true;
                  }
                  _loc3_++;
               }
            }
            _loc2_++;
         }
         return false;
      }
      
      protected function UIComponentHintClick(param1:Object, param2:Object) : void
      {
         var _loc3_:TInventory = param2 as TInventory;
         var _loc4_:int = 0;
         var _loc5_:TUISlot = param1 as TUISlot;
         if(_loc3_.Quantity == 0)
         {
            return;
         }
         if(_loc5_.IsHaveFilters)
         {
            return;
         }
         if(this.FRightCount >= 3)
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
         var _loc6_:int = 0;
         while(_loc6_ < this.FTempSelectInventoriesId.length)
         {
            if(this.F_0_1[_loc6_].Identifier1 == _loc3_.Identifier1 && this.F_0_1[_loc6_].Identifier0 == _loc3_.Identifier0)
            {
               if(this.FTempSelectInventoriesCount[_loc6_] == 99)
               {
                  return;
               }
               if(this.FTempSelectInventoriesCount[_loc6_] + _loc4_ > 90)
               {
                  _loc4_ = 99 - this.FTempSelectInventoriesCount[_loc6_];
               }
            }
            _loc6_++;
         }
         this.FUIWindowEditor.Context = _loc3_;
         this.FUIWindowEditor.Label = _loc3_.Name;
         this.FUIWindowEditor.Quantity = String(_loc4_);
         this.FUIWindowEditor.Value = _loc4_;
         this.FUIWindowEditor.Max = _loc4_;
         this.FUIWindowEditor.Min = 1;
         this.FUIWindowEditor.visible = true;
      }
      
      protected function reflshFilter() : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:TInventory = null;
         var _loc5_:int = 0;
         var _loc1_:int = int(this.VecInventorys.length);
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < UPCOUNT)
         {
            _loc5_ = _loc2_ + (this.FurGodIndex - 1) * UPCOUNT;
            if(_loc5_ <= _loc1_ - 1)
            {
               _loc4_ = this.UpVecLists[_loc2_].Context as TInventory;
               if(_loc4_)
               {
                  if(_loc4_.Quantity <= 0)
                  {
                     _loc3_ = true;
                  }
                  else if(this.GetBooBelIsFilters(_loc4_))
                  {
                     _loc3_ = false;
                  }
                  else
                  {
                     _loc3_ = true;
                  }
                  this.UpVecLists[_loc2_].SetDefaultFilters(_loc3_);
               }
            }
            _loc2_++;
         }
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
      }
      
      public function ClearBtn() : void
      {
         while(this.FSelectInventories.Count)
         {
            this.UIComponentHint(this.DownVecLists[0],this.FSelectInventories.GetInventoryByIndex(0));
         }
      }
      
      public function CloseMe() : void
      {
         this.ClearBtn();
      }
      
      public function JinhuaSend(param1:MouseEvent) : void
      {
         if(this.FDataObj == null)
         {
            return;
         }
         if(this.FDataObj.isCanEvolve == 0)
         {
            this.FExteShow(STRING_TONGLING.TONGLING_10);
            return;
         }
         if(this.FDataObj.PosPeiYang != 0)
         {
            this.FExteShow(STRING_TONGLING.TONGLING_11);
            return;
         }
         this.TPopWindow.Text = STRING_TONGLING.TONGLING_12;
         this.TPopWindow.visible = true;
      }
      
      public function PopWindowOnOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_TongLingJinHua_Rep);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(this.FDataObj.Identifier0);
         _loc3_.writeUnsignedInt(this.FDataObj.Identifier1);
         _loc3_.writeShort(this.F_0_1.length);
         var _loc4_:int = 0;
         while(_loc4_ < this.F_0_1.length)
         {
            _loc3_.writeUnsignedInt(this.F_0_1[_loc4_].Identifier0);
            _loc3_.writeUnsignedInt(this.F_0_1[_loc4_].Identifier1);
            _loc3_.writeUnsignedInt(this.FTempSelectInventoriesCount[_loc4_]);
            _loc4_++;
         }
         this.ClearBtn();
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
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
            _loc6_.LoadSecondary(_loc5_.IDTexture,CONST_MODULES.MODULE_TongLing);
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
      
      public function updatePic() : void
      {
         var _loc1_:int = 0;
         if(this.FIsUpdate)
         {
            return;
         }
         var _loc2_:int = int(this.VecInventorys.length);
         if(_loc2_ == 0)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < UPCOUNT)
         {
            if(_loc1_ + (this.FurGodIndex - 1) * UPCOUNT <= _loc2_ - 1)
            {
               this.UpVecLists[_loc1_].Update();
            }
            _loc1_++;
         }
         if(this.FRightCount != 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.FRightCount)
            {
               this.DownVecLists[_loc1_].Update();
               _loc1_++;
            }
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         if(this.FDataObj == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < JIANHUACOUNT)
         {
            this.VecFours[_loc1_].Update1();
            _loc1_++;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Pet,this.FHeadBmp,CONST_MODULES.MODULE_TongLing,this.FStatus.SmPic,1);
      }
      
      protected function SetValue() : void
      {
         var _loc2_:TUISlot = null;
         var _loc3_:jinhuaCellFour = null;
         var _loc1_:int = 0;
         MovieClip(this.FRootPanle["MC_Shop_Btn"]).addEventListener(MouseEvent.CLICK,this.BtnClick);
         MovieClip(this.FRootPanle["MC_Path_Btn"]).addEventListener(MouseEvent.CLICK,this.BtnPathClick);
         MovieClip(this.FRootPanle["mc_buy_reel"]).addEventListener(MouseEvent.CLICK,this.BtnreelClick);
         MovieClip(this.FRootPanle["MC_Summary"]).addEventListener(MouseEvent.CLICK,this.JinhuaSend);
         MovieClip(this.FRootPanle["btn_left"]).addEventListener(MouseEvent.CLICK,this.selClick);
         MovieClip(this.FRootPanle["btn_right"]).addEventListener(MouseEvent.CLICK,this.selClick);
         TGameUtil.setButtonMode(MovieClip(this.FRootPanle["MC_Summary"]),true);
         TGameUtil.setButtonMode(MovieClip(this.FRootPanle["MC_Shop_Btn"]),true);
         TGameUtil.setButtonMode(MovieClip(this.FRootPanle["MC_Path_Btn"]),true);
         TGameUtil.setButtonMode(MovieClip(this.FRootPanle["mc_buy_reel"]),true);
         MovieClip(this.FRootPanle["Pic"]).addChild(this.FHeadBmp);
         this.FallJinHua = this.FRootPanle["TF_Text_All"] as TextField;
         this.FthisJinHua = this.FRootPanle["TF_Text_Cur"] as TextField;
         this.VecFourText.push(this.FallJinHua,this.FthisJinHua,this.FRootPanle["TF_Text_All1"],this.FRootPanle["TF_Text_Cur1"]);
         while(_loc1_ < UPCOUNT)
         {
            _loc2_ = new TUISlot(this);
            _loc2_.Resource = this.FRootPanle[CONST_TONGLINGANIMAL.TONGLING_03_MC_Slot_0 + _loc1_] as MovieClip;
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
            _loc2_.Resource = this.FRootPanle[CONST_TONGLINGANIMAL.TONGLING_03_MC_Slot_00 + _loc1_] as MovieClip;
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
         _loc1_ = 0;
         while(_loc1_ < JIANHUACOUNT)
         {
            _loc3_ = new jinhuaCellFour(MovieClip(this.FRootPanle[CONST_TONGLINGANIMAL.TONGLING_03_MC_Slot_ + _loc1_]));
            this.VecFours[_loc1_] = _loc3_;
            this.VecFours[_loc1_].MoveClick = this.moveclick;
            this.VecFours[_loc1_].OutClick = this.outclick;
            this.VecFours[_loc1_].OverClick = this.overclick;
            _loc1_++;
         }
         this.TPopWindow = new TUIWindowConfirmation(this.FPerCompoent);
         this.TPopWindow.OnOK = this.PopWindowOnOk;
         this.TPopWindow.x = this.FUcore.StageWidth - this.TPopWindow.WindowWidth >> 1;
         this.TPopWindow.y = this.FUcore.StageHeight - this.TPopWindow.WindowHeight >> 1;
         TUtilityUIWindow.SetupWindowConfirmation(this.TPopWindow);
         this.TPopWindow.visible = false;
         this.FOverlayerAppliance = new TOverlayerAppliance(this.FPerCompoent,CONST_MODULES.MODULE_TongLing);
         this.FOverlayerAppliance.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerAppliance);
         this.FTipShop = new TongLingAttriteTip(this.FPerCompoent);
         this.FTipShop.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FTipShop);
         this.FIntroTip = new TongLingIntroTip(this.FPerCompoent);
         this.FIntroTip.Visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FIntroTip);
         _loc1_ = 0;
         while(_loc1_ < this.VecFourText.length)
         {
            this.VecFourText[_loc1_].addEventListener(MouseEvent.MOUSE_OVER,this.OverHandle);
            this.VecFourText[_loc1_].addEventListener(MouseEvent.MOUSE_OUT,this.OutHandle);
            this.VecFourText[_loc1_].addEventListener(MouseEvent.MOUSE_MOVE,this.MoveHandle);
            _loc1_++;
         }
         MovieClip(this.FRootPanle["mc_buy_reel"]).addEventListener(MouseEvent.MOUSE_OVER,this.OverHandle);
         MovieClip(this.FRootPanle["mc_buy_reel"]).addEventListener(MouseEvent.MOUSE_OUT,this.OutHandle);
         MovieClip(this.FRootPanle["mc_buy_reel"]).addEventListener(MouseEvent.MOUSE_MOVE,this.MoveHandle);
         this.FIsUpdate = 0;
      }
      
      public function OverHandle(param1:MouseEvent) : void
      {
         if(this.FRootPanle == null)
         {
            return;
         }
         var _loc2_:int = 0;
         switch(param1.currentTarget)
         {
            case this.FRootPanle["TF_Text_All"]:
               _loc2_ = 8;
               break;
            case this.FRootPanle["TF_Text_All1"]:
               _loc2_ = 8;
               break;
            case this.FRootPanle["TF_Text_Cur"]:
               _loc2_ = 7;
               break;
            case this.FRootPanle["TF_Text_Cur1"]:
               _loc2_ = 7;
               break;
            case this.FRootPanle["mc_buy_reel"]:
               _loc2_ = 10;
         }
         this.FIntroTip.Context = _loc2_;
         this.FIntroTip.Render(this.FUcore.MouseCoordinate);
         this.FIntroTip.Show();
      }
      
      public function OutHandle(param1:MouseEvent) : void
      {
         this.FIntroTip.Hide();
      }
      
      public function MoveHandle(param1:MouseEvent) : void
      {
         this.FIntroTip.Render(this.FUcore.MouseCoordinate);
      }
      
      public function overclick(param1:int) : void
      {
         var _loc2_:Object = {
            "id":param1,
            "index":1,
            "level":1,
            "Identifier0":this.FDataObj.Identifier0,
            "Identifier1":this.FDataObj.Identifier1
         };
         this.FTipShop.Context = _loc2_;
         this.FTipShop.Render(this.FUcore.MouseCoordinate);
         this.FTipShop.Show();
      }
      
      public function outclick(param1:int) : void
      {
         this.FTipShop.Hide();
      }
      
      public function moveclick(param1:int) : void
      {
         this.FTipShop.Render(this.FUcore.MouseCoordinate);
      }
      
      public function set allJinHua(param1:String) : void
      {
         this.FallJinHua.text = param1;
      }
      
      public function set thisJinHua(param1:String) : void
      {
         this.FthisJinHua.text = param1;
      }
      
      protected function getStr(param1:String) : Array
      {
         var _loc4_:int = 0;
         param1 = param1.substring(1,param1.length - 1);
         var _loc2_:Array = new Array();
         var _loc3_:int = 0;
         while(true)
         {
            _loc3_ = param1.indexOf("[",_loc3_);
            if(_loc3_ == -1)
            {
               break;
            }
            _loc4_ = param1.indexOf("]",_loc3_);
            if(_loc4_ == -1)
            {
               return _loc2_;
            }
            _loc3_ += 1;
            _loc2_.push(param1.substring(_loc3_,_loc4_).split(","));
            _loc3_ = _loc4_;
         }
         return _loc2_;
      }
      
      protected function JinHuaShow(param1:int) : void
      {
         var _loc5_:TBB_Status = null;
         var _loc6_:TBB_EvoPoint = null;
         var _loc11_:TInventory = null;
         var _loc12_:TBB_LuckyCard = null;
         var _loc13_:Array = null;
         var _loc15_:String = null;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:Number = NaN;
         var _loc20_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc5_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_Status,param1) as TBB_Status;
         _loc2_ = _loc5_.GetPoint;
         var _loc7_:String = _loc5_.EvoTarget;
         var _loc8_:Array = this.getStr(_loc7_);
         this.FCanChangeArr = _loc8_;
         this.FShoeArr.length = 0;
         var _loc9_:int = 0;
         while(_loc4_ < this.FCanChangeArr.length)
         {
            if(this.FCanChangeArr[_loc4_][0] != 0)
            {
               _loc9_ += int(this.FCanChangeArr[_loc4_][0]);
               this.FShoeArr.push([this.FCanChangeArr[_loc4_][0],this.FCanChangeArr[_loc4_][0],this.FCanChangeArr[_loc4_][1],_loc5_.Rarity]);
            }
            _loc4_++;
         }
         if(_loc9_ == 0)
         {
            this.setStateEvolev(false);
         }
         else
         {
            this.setStateEvolev(true);
         }
         _loc4_ = 0;
         while(_loc4_ < this.FShoeArr.length)
         {
            this.FShoeArr[_loc4_][1] = _loc9_;
            _loc4_++;
         }
         var _loc10_:int = this.FSelectInventories.Count;
         _loc4_ = 0;
         while(_loc4_ < _loc10_)
         {
            _loc11_ = this.FSelectInventories.GetInventoryByIndex(_loc4_);
            _loc12_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_LuckyCard,_loc11_.IDTemplate) as TBB_LuckyCard;
            _loc6_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_BB_EvoPoint,_loc11_.IDTemplate) as TBB_EvoPoint;
            _loc2_ += _loc6_.GetPoint * _loc11_.Quantity;
            _loc15_ = _loc12_.EvoRate;
            _loc13_ = this.getStr(_loc15_);
            _loc16_ = 0;
            while(_loc16_ < _loc13_.length)
            {
               if(int(_loc13_[_loc16_][1]) < 100)
               {
                  _loc17_ = 3;
               }
               else
               {
                  _loc17_ = 2;
               }
               _loc18_ = 0;
               while(_loc18_ < this.FShoeArr.length)
               {
                  if(_loc18_ < this.FShoeArr.length)
                  {
                     if(_loc13_[_loc16_][1] == this.FShoeArr[_loc18_][_loc17_])
                     {
                        this.FShoeArr[_loc18_][0] = int(this.FShoeArr[_loc18_][0]) + int(_loc13_[_loc16_][0]) * _loc11_.Quantity;
                        _loc3_ += int(_loc13_[_loc16_][0]) * _loc11_.Quantity;
                     }
                  }
                  _loc18_++;
               }
               _loc16_++;
            }
            _loc4_++;
         }
         var _loc14_:int = 0;
         while(_loc14_ < this.FShoeArr.length)
         {
            this.FShoeArr[_loc14_][1] += _loc3_;
            _loc14_++;
         }
         _loc4_ = 0;
         while(_loc4_ < JIANHUACOUNT)
         {
            if(_loc4_ >= this.FShoeArr.length)
            {
               this.VecFours[_loc4_].SetCoent(0);
               TextField(this.FRootPanle["tt_0" + _loc4_]).text = "";
            }
            else
            {
               this.VecFours[_loc4_].SetCoent(this.FShoeArr[_loc4_][2]);
               _loc19_ = Number(Number(this.FShoeArr[_loc4_][0]) / Number(this.FShoeArr[_loc4_][1])) * 100;
               _loc20_ = this.getScr(_loc19_);
               TextField(this.FRootPanle["tt_0" + _loc4_]).text = _loc20_[1];
               TextField(this.FRootPanle["tt_0" + _loc4_]).textColor = QUALITYCOLOR_INDEX[_loc20_[0]];
            }
            _loc4_++;
         }
         this.FthisJinHua.text = String(_loc2_);
         this.reflshFilter();
      }
      
      protected function getScr(param1:Number) : Array
      {
         var _loc2_:String = null;
         var _loc3_:Array = new Array();
         var _loc4_:int = this.AtrConditions.length - 1;
         if(param1 <= 0)
         {
            _loc3_.push(this.AtrConditions[0][1],this.AtrConditions[0][2]);
            return _loc3_;
         }
         if(param1 >= 100)
         {
            _loc3_.push(this.AtrConditions[_loc4_][1],this.AtrConditions[_loc4_][2]);
            return _loc3_;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(int(this.AtrConditions[_loc5_][0]) < param1 && param1 <= int(this.AtrConditions[_loc5_ + 1][0]))
            {
               _loc3_.push(this.AtrConditions[_loc5_ + 1][1],this.AtrConditions[_loc5_ + 1][2]);
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public function set ExteShow(param1:Function) : void
      {
         this.FExteShow = param1;
      }
      
      protected function setBtnState2() : void
      {
         if(this.FAllGodIndex <= 1)
         {
            TGameUtil.setButtonMode(MovieClip(this.FRootPanle["btn_left"]),false);
            TGameUtil.setButtonMode(MovieClip(this.FRootPanle["btn_right"]),false);
         }
         else
         {
            TGameUtil.setButtonMode(MovieClip(this.FRootPanle["btn_left"]),this.FurGodIndex == 1 ? false : true);
            TGameUtil.setButtonMode(MovieClip(this.FRootPanle["btn_right"]),this.FurGodIndex >= this.FAllGodIndex ? false : true);
         }
      }
      
      public function setStateEvolev(param1:Boolean) : void
      {
      }
      
      public function ResetSlot() : void
      {
         var _loc1_:uint = 0;
         _loc1_ = 0;
         while(_loc1_ < UPCOUNT)
         {
            if(this.UpVecLists[_loc1_])
            {
               this.UpVecLists[_loc1_].Context = null;
            }
            _loc1_++;
         }
      }
   }
}


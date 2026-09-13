package Processors.Game.Lobby.Emblem
{
   import Components.ScrollBar.TScrollNobar;
   import Components.Standard.TUITab;
   import Foundation.Common.Integer.UInt64;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TEmblem;
   import Logics.DatebaseVO.VO.TEmblemRing;
   import Logics.Emblem.TEmblemData;
   import Logics.Inventories.TInventories;
   import Logics.SLogicsCore;
   import Logics.Streamization.Emblem.TUnstreamizerEmblem;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Emblem.Component.TUIEmblemBox;
   import Processors.Game.Lobby.Emblem.Component.TUIEmblemPromptFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_EMBLEM;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   
   public class TProcessorEmblem extends TProcessorLobbyWindows
   {
      
      protected var FScrollNobar:TScrollNobar;
      
      protected var FMC_List:MovieClip;
      
      protected var FUIEmblemBoxList:Vector.<TUIEmblemBox>;
      
      protected var FUITab:TUITab;
      
      protected var FTabIndex:int;
      
      protected var FEmblemIcon:Bitmap;
      
      protected var FRingEffect:Bitmap;
      
      protected var FBTN_Upgrade:MovieClip;
      
      protected var FMainScene:MovieClip;
      
      protected var FCloseBtn:SimpleButton;
      
      protected var FBTN_Help:SimpleButton;
      
      protected var FMaskWidth:uint;
      
      protected var FProcessorWindowEmblem:TProcessorWindowEmblem;
      
      protected var FUIEmblemPromptFrame:TUIEmblemPromptFrame;
      
      protected var FUIWindowConfirmation:TUIWindowConfirmation;
      
      protected var FUnstreamizerEmblem:TUnstreamizerEmblem;
      
      protected var FHint:THint;
      
      protected var FRingResourceId:int;
      
      protected var FCostItemId:int;
      
      public function TProcessorEmblem(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         this.FProcessorWindowEmblem = new TProcessorWindowEmblem(param1,this);
         this.FProcessorWindowEmblem.OnUploadCompleteHandler = this.OnUploadCompleteHandler;
         this.FProcessorWindowEmblem.OnConfirmCallback = this.ProcessorOnConfirm;
         this.FProcessorWindowEmblem.OnHelpMouseOver = this.OnHelpMouseOver;
         this.FProcessorWindowEmblem.OnHelpMouseOut = this.OnHelpMouseOut;
         this.FUIEmblemPromptFrame = new TUIEmblemPromptFrame(param1);
         this.FUIEmblemPromptFrame.ProcessorEmblem = this;
         this.FUIWindowConfirmation = new TUIWindowConfirmation(param1);
         this.FUIWindowConfirmation.OnOK = this.ConfirmationOnOk;
         this.FUIWindowConfirmation.x = (FUICore.StageWidth - this.FUIWindowConfirmation.WindowWidth) / 2;
         this.FUIWindowConfirmation.y = (FUICore.StageHeight - this.FUIWindowConfirmation.WindowHeight) / 2 - 20;
         this.FUnstreamizerEmblem = new TUnstreamizerEmblem();
         this.FHint = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_Emblem);
      }
      
      public static function MergeAddAttribute(param1:Array, param2:Array) : Array
      {
         var _loc3_:Array = null;
         for each(_loc3_ in param1)
         {
            if(_loc3_[0] == param2[0])
            {
               _loc3_[1] += param2[1];
               return param1;
            }
         }
         param1.push([param2[0],param2[1]]);
         return param1;
      }
      
      public static function AttributeFormat(param1:int, param2:Number = 0, param3:Number = 0) : String
      {
         var _loc4_:int = CONST_COMMON.BASEATTRIBUTENAMES.indexOf(param1);
         var _loc5_:String = "";
         if(_loc4_ >= 0)
         {
            _loc5_ = STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[_loc4_];
         }
         if(param2 != 0)
         {
            if(param2 > 1)
            {
               _loc5_ += param2;
            }
            else
            {
               _loc5_ += (param2 * 100).toFixed(0) + "%";
            }
         }
         if(param3 != 0)
         {
            if(param3 > 1)
            {
               _loc5_ += " -> " + param3;
            }
            else
            {
               _loc5_ += " —> " + (param3 * 100).toFixed(0) + "%";
            }
         }
         return _loc5_;
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4026531842);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc1_:TConfigValue = null;
         super.ResourcesPerform_UIDispatch();
         this.FMainScene = TUtilityReflection.CreateDisplayObjectInstance("MC_Emblem") as MovieClip;
         addChild(this.FMainScene);
         this.FMC_List = this.FMainScene["mc_list"];
         this.FScrollNobar = new TScrollNobar(this.FMC_List,380,false,10,15,3,10);
         this.FUITab = new TUITab(this);
         this.FUITab.SetTabByIndex(this.FMainScene["mc_tab_0"],0);
         this.FUITab.SetTabByIndex(this.FMainScene["mc_tab_1"],1);
         this.FUITab.OnSwitch = this.OnTabChange;
         this.FUITab.Init();
         this.FUIEmblemBoxList = new Vector.<TUIEmblemBox>();
         this.FEmblemIcon = new Bitmap();
         this.FMainScene["FEmblemBox"]["pos"].addChild(this.FEmblemIcon);
         this.FRingEffect = new Bitmap();
         this.FMainScene["FEmblemBox"]["effSpr"].addChild(this.FRingEffect);
         this.FBTN_Upgrade = this.FMainScene["BTN_upgrade"];
         TGameUtil.setButtonMode(this.FBTN_Upgrade,true);
         this.FMainScene.x = FUICore.StageWidth - this.FMainScene.width >> 1;
         this.FMainScene.y = FUICore.StageHeight - this.FMainScene.height >> 1;
         this.FCloseBtn = this.FMainScene["BTN_Close"];
         this.FBTN_Help = this.FMainScene["BTN_Help"];
         this.ConstructScroolBar();
         TUtilityUIWindow.SetupWindowConfirmation(this.FUIWindowConfirmation);
         _loc1_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.Emblem) as TConfigValue;
         this.FCostItemId = _loc1_.Value[0];
         this.FMaskWidth = this.FMainScene["MC_Bar"]["MC_Mask"].width;
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBTN_Upgrade.addEventListener(MouseEvent.CLICK,this.OnClickUpgradeBtn);
         this.FCloseBtn.addEventListener(MouseEvent.CLICK,this.OnCloseHandler);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_MOVE,this.OnButtonHelpOver);
         this.FBTN_Help.addEventListener(MouseEvent.MOUSE_OUT,this.OnButtonHelpOut);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Emblem_Info_Ret,this.PerformPacket_SC_Emblem_Info);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Emblem_Unlock_Ret,this.PerformPacket_SC_Emblem_Unlock);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Emblem_Upgrade_Ret,this.PerformPacket_SC_Emblem_Upgrade);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Emblem_Set_Ret,this.PerformPacket_SC_Emblem_Set);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Emblem_Update_Ret,this.PerformPacket_SC_Emblem_Update);
      }
      
      override protected function LogicsPerform() : void
      {
         if(!FIsResourcesLoadCompleted)
         {
            return;
         }
         TGameUtil.ShowAnimationByID(TGameUtil.Type_Emblem,this.FRingEffect,CONST_MODULES.MODULE_Emblem,this.FRingResourceId,0);
         this.FRingEffect.x = -this.FRingEffect.width >> 1;
         this.FRingEffect.y = -this.FRingEffect.height >> 1;
         super.LogicsPerform();
      }
      
      protected function PerformPacket_SC_Emblem_Info(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         _loc2_ = param1.Data;
         this.FUnstreamizerEmblem.Unstreamize(_loc2_,null,null);
         this.SetEmblemInfo(this.FUnstreamizerEmblem.EmblemDatas);
         this.OnTabChange(this.FTabIndex);
         this.updateEmblemRing(this.FUnstreamizerEmblem.RingId,this.FUnstreamizerEmblem.RingExp);
         this.PacketPerform_CS_Emblem_Set(this.FUnstreamizerEmblem.EmblemId);
         this.PacketPerform_CS_Emblem_Set(this.FUnstreamizerEmblem.Currid);
      }
      
      protected function PerformPacket_SC_Emblem_Upgrade(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         var _loc4_:int = _loc2_.readInt();
         var _loc5_:int = _loc2_.readInt();
         this.updateEmblemRing(_loc4_,_loc5_);
      }
      
      protected function PerformPacket_SC_Emblem_Unlock(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            return;
         }
         this.FUnstreamizerEmblem.UpdateEmblemByEmblemId(_loc2_,null,null);
         this.OnTabChange(this.FTabIndex);
      }
      
      protected function PerformPacket_SC_Emblem_Update(param1:TPacket) : void
      {
         var _loc2_:ByteArray = null;
         var _loc3_:int = 0;
         var _loc4_:TUIEmblemBox = null;
         _loc2_ = param1.Data;
         _loc3_ = _loc2_.readInt();
         _loc4_ = this.filterEmblemBoxById(_loc3_);
         _loc4_.EmblemData.Name = TUtilityString.FetchUTF(_loc2_);
         _loc4_.SetEmblemInfo(_loc4_.EmblemData);
      }
      
      protected function PerformPacket_SC_Emblem_Set(param1:TPacket) : void
      {
         var Data:ByteArray = null;
         var FEmblemId:int = 0;
         var FEmblemBox:TUIEmblemBox = null;
         var FEmblemVO:TEmblem = null;
         var FBitmap:Bitmap = null;
         var callback:Function = null;
         var Packet:TPacket = param1;
         callback = function():void
         {
            if(FEmblemBox.MC_Bitmap.numChildren > 0)
            {
               FBitmap = FEmblemBox.MC_Bitmap.getChildAt(0) as Bitmap;
            }
            if(FBitmap)
            {
               FEmblemIcon.bitmapData = FBitmap.bitmapData;
               FEmblemIcon.x = -FEmblemIcon.width >> 1;
               FEmblemIcon.y = -FEmblemIcon.height >> 1;
            }
         };
         Data = Packet.Data;
         FEmblemId = Data.readInt();
         FEmblemVO = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Emblem,FEmblemId) as TEmblem;
         if(FEmblemVO.Type == 3)
         {
            this.FRingResourceId = FEmblemVO.Unlockcondition;
            return;
         }
         FEmblemBox = this.filterEmblemBoxById(FEmblemId);
         FEmblemBox.OnCompleteCallback = callback;
         this.FEmblemIcon.bitmapData = null;
         callback();
      }
      
      protected function PacketPerform_CS_Emblem_Info() : void
      {
         var _loc1_:TPacket = null;
         _loc1_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Emblem_Info_Req);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      protected function PacketPerform_CS_Emblem_Unlock(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Emblem_Unlock_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PacketPerform_CS_Emblem_Upgrade(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Emblem_Upgrade_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function PacketPerform_CS_Emblem_Update(param1:int, param2:String) : void
      {
         var _loc3_:TPacket = null;
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Emblem_Update_Req);
         _loc3_.Data.writeInt(param1);
         TUtilityString.FlushUTF(_loc3_.Data,param2);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function PacketPerform_CS_Emblem_Set(param1:int) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Emblem_Set_Req);
         _loc2_.Data.writeInt(param1);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
      }
      
      protected function ConstructScroolBar() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TUIEmblemBox = null;
         var _loc4_:TBins = null;
         _loc4_ = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_Emblem);
         _loc1_ = 0;
         while(_loc1_ < _loc4_.Count)
         {
            _loc3_ = new TUIEmblemBox(this);
            _loc3_.OnLockClick = this.OnEmblemLockClick;
            _loc3_.OnLockOver = this.OnEmblemLockOnOver;
            _loc3_.OnLockOut = this.OnEmblemLockOnOut;
            _loc3_.OnAddClick = this.OnEmblemAddClick;
            _loc3_.OnBoxClick = this.OnEmblemBoxClick;
            _loc3_.OnBoxOver = this.OnEmblemBoxOver;
            _loc3_.OnBoxOut = this.OnEmblemBoxOut;
            this.FUIEmblemBoxList.push(_loc3_);
            _loc1_++;
         }
      }
      
      protected function SetEmblemInfo(param1:Vector.<TEmblemData>) : void
      {
         var _loc2_:TUIEmblemBox = null;
         var _loc3_:int = 0;
         var _loc4_:TextField = null;
         if(param1)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_ = this.FUIEmblemBoxList[_loc3_];
               _loc2_.SetEmblemInfo(param1[_loc3_]);
               _loc3_++;
            }
         }
         this.FMainScene["TF_Amount"].text = this.FUnstreamizerEmblem.EmblemNum;
         this.FormatAddAttribute(param1);
      }
      
      protected function updataEmblemScrollView(param1:Array) : void
      {
         var _loc2_:TUIEmblemBox = null;
         var _loc3_:TEmblemData = null;
         var _loc4_:int = 0;
         this.FScrollNobar.Clear();
         var _loc5_:int = 0;
         if(param1)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc3_ = param1[_loc4_];
               _loc5_ = 0;
               while(_loc5_ < this.FUIEmblemBoxList.length)
               {
                  _loc2_ = this.FUIEmblemBoxList[_loc5_];
                  if(_loc2_.EmblemData.EmblemId == _loc3_.EmblemId)
                  {
                     _loc2_.SetEmblemInfo(_loc3_);
                     this.FScrollNobar.AddItem(_loc2_);
                  }
                  _loc5_++;
               }
               _loc4_++;
            }
         }
      }
      
      protected function updateEmblemRing(param1:int, param2:int) : void
      {
         var _loc3_:TEmblemRing = null;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_EmblemRing,param1) as TEmblemRing;
         this.FMainScene["TF_Level"].text = TUtilityString.Format(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Emblem_04),_loc3_.Class,_loc3_.Classlevel);
         this.FMainScene["TF_EXP"].text = TUtilityString.Format(TUtilityString.GetText(70470011),param2 - _loc3_.AllExp,_loc3_.NeedExp);
         this.FMainScene["MC_Bar"]["MC_Mask"].width = (param2 - _loc3_.AllExp) / _loc3_.NeedExp * this.FMaskWidth;
         this.FMainScene["TF_Count"].text = this.getInventoryById();
         this.FormatTotalAttribute(_loc3_);
      }
      
      protected function FormatAddAttribute(param1:Vector.<TEmblemData>) : void
      {
         var _loc2_:TEmblemData = null;
         var _loc3_:TEmblem = null;
         var _loc4_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:Array = null;
         var _loc5_:Array = [];
         if(param1)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc2_ = param1[_loc4_];
               if(_loc2_.Unlock == CONST_EMBLEM.UNLOCK)
               {
                  _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Emblem,_loc2_.EmblemId) as TEmblem;
                  _loc6_ = _loc3_.AddAttributes;
                  for each(_loc7_ in _loc6_)
                  {
                     MergeAddAttribute(_loc5_,_loc7_);
                  }
               }
               _loc4_++;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc6_ = _loc5_[_loc4_];
            this.FMainScene["MC_BonusAttribute_" + _loc4_]["TF_Attribute"].text = AttributeFormat(_loc6_[0]);
            this.FMainScene["MC_BonusAttribute_" + _loc4_]["TF_AttriValue"].text = AttributeFormat(0,_loc6_[1]);
            _loc4_++;
         }
      }
      
      protected function FormatTotalAttribute(param1:TEmblemRing) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:TEmblemRing = null;
         var _loc6_:Array = null;
         _loc5_ = param1.NextEmblemRing;
         _loc2_ = int(param1.Porperties.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1.Porperties[_loc4_];
            this.FMainScene["MC_Attribute_" + _loc4_]["TF_Attribute"].text = AttributeFormat(_loc3_[0]);
            if(_loc5_)
            {
               _loc6_ = _loc5_.Porperties[_loc4_];
               this.FMainScene["MC_Attribute_" + _loc4_]["TF_AttriValue"].text = AttributeFormat(0,_loc3_[1],_loc6_[1]);
            }
            else
            {
               this.FMainScene["MC_Attribute_" + _loc4_]["TF_AttriValue"].text = AttributeFormat(0,_loc3_[1]);
            }
            _loc4_++;
         }
      }
      
      protected function OnTabChange(param1:int) : void
      {
         this.FTabIndex = param1;
         this.updataEmblemScrollView(this.filterEmblemDataByPageIndex(param1));
      }
      
      protected function ProcessorOnConfirm() : void
      {
         this.FUIWindowConfirmation.Text = TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Emblem_02);
         this.FUIWindowConfirmation.Tag = 2;
         this.FUIWindowConfirmation.Visible = true;
      }
      
      protected function OnEmblemLockClick(param1:TUIEmblemBox) : void
      {
         if(param1.Unlock == CONST_EMBLEM.CANLOCK)
         {
            this.FUIWindowConfirmation.Text = param1.EmblemData.Tips + "\n" + TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Emblem_03);
            this.FUIWindowConfirmation.Context = param1.EmblemData.EmblemId;
            this.FUIWindowConfirmation.Tag = 1;
            this.FUIWindowConfirmation.Visible = true;
         }
         else if(param1.Unlock == CONST_EMBLEM.LOCK)
         {
            EffectGenerateText(param1.EmblemData.ErrorText);
         }
      }
      
      protected function OnEmblemAddClick(param1:TUIEmblemBox) : void
      {
         if(this.FProcessorWindowEmblem)
         {
            this.FProcessorWindowEmblem.EmblemId = param1.EmblemData.EmblemId;
            this.FProcessorWindowEmblem.Visible = true;
         }
      }
      
      protected function OnEmblemBoxClick(param1:TUIEmblemBox) : void
      {
         if(param1.EmblemData.Unlock == CONST_EMBLEM.UNLOCK && param1.EmblemData.Name != "")
         {
            this.PacketPerform_CS_Emblem_Set(param1.EmblemData.EmblemId);
         }
      }
      
      protected function OnEmblemBoxOver(param1:TUIEmblemBox) : void
      {
         var _loc2_:TEmblem = null;
         var _loc3_:Array = null;
         var _loc5_:Array = null;
         var _loc4_:String = "";
         if(param1.Unlock == CONST_EMBLEM.UNLOCK)
         {
            _loc2_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Emblem,param1.EmblemData.EmblemId) as TEmblem;
            _loc3_ = _loc2_.AddAttributes;
            for each(_loc5_ in _loc3_)
            {
               _loc4_ += AttributeFormat(_loc5_[0],_loc5_[1]) + "\n";
            }
            this.FHint.Caption = _loc4_;
            ProcessorTipOnOver(this,this.FHint);
         }
      }
      
      protected function OnEmblemBoxOut(param1:TUIEmblemBox) : void
      {
         ProcessorTipOnOut(this);
      }
      
      protected function OnEmblemLockOnOver(param1:TUIEmblemBox) : void
      {
         this.FHint.Caption = param1.EmblemData.Tips;
         ProcessorTipOnOver(this,this.FHint);
      }
      
      protected function OnEmblemLockOnOut(param1:TUIEmblemBox) : void
      {
         ProcessorTipOnOut(this);
      }
      
      protected function ConfirmationOnOk(param1:Object) : void
      {
         if(this.FUIWindowConfirmation.Tag == 1)
         {
            this.PacketPerform_CS_Emblem_Unlock(int(this.FUIWindowConfirmation.Context));
         }
         else
         {
            this.FProcessorWindowEmblem.StartupLoadFile();
         }
      }
      
      protected function OnUploadCompleteHandler(param1:int, param2:String) : void
      {
         this.PacketPerform_CS_Emblem_Update(param1,param2);
      }
      
      protected function OnHelpMouseOver() : void
      {
         this.FHint.Content = TUtilityString.GetText(70170121);
         UIHelpTipsHintOnOver(this,this.FHint);
      }
      
      protected function OnHelpMouseOut() : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      protected function OnClickUpgradeBtn(param1:MouseEvent) : void
      {
         var e:MouseEvent = param1;
         if(this.getInventoryById() < 1)
         {
            EffectGenerateText(TUtilityString.GetText(CONST_SYSTEMLANGUAGE.STRING_Emblem_01));
            return;
         }
         this.FUIEmblemPromptFrame.ShowPrompt(function(param1:int):void
         {
            PacketPerform_CS_Emblem_Upgrade(param1);
         });
      }
      
      protected function OnCloseHandler(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function OnButtonHelpOver(param1:MouseEvent) : void
      {
         this.FHint.Content = TUtilityString.GetText(70170120);
         UIHelpTipsHintOnOver(this,this.FHint);
      }
      
      protected function OnButtonHelpOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      protected function filterEmblemDataByPageIndex(param1:int) : Array
      {
         var _loc4_:TEmblemData = null;
         var _loc5_:int = 0;
         var _loc2_:Array = [[],[]];
         var _loc3_:Vector.<TEmblemData> = this.FUnstreamizerEmblem.EmblemDatas;
         if(_loc3_)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_.length)
            {
               _loc4_ = _loc3_[_loc5_];
               if(param1 == 0 && (_loc4_.Type == 1 || _loc4_.Type == 2))
               {
                  _loc2_[0].push(_loc4_);
               }
               else if(param1 == 1 && _loc4_.Type == 3)
               {
                  _loc2_[1].push(_loc4_);
               }
               _loc5_++;
            }
         }
         return _loc2_[param1];
      }
      
      protected function filterEmblemBoxById(param1:int) : TUIEmblemBox
      {
         var _loc2_:TUIEmblemBox = null;
         var _loc3_:int = 0;
         if(this.FUIEmblemBoxList)
         {
            _loc3_ = 0;
            while(_loc3_ < this.FUIEmblemBoxList.length)
            {
               _loc2_ = this.FUIEmblemBoxList[_loc3_];
               if(param1 == _loc2_.EmblemData.EmblemId)
               {
                  return _loc2_;
               }
               _loc3_++;
            }
         }
         return null;
      }
      
      public function getInventoryById() : int
      {
         var _loc1_:TInventories = SLogicsCore.Character.Appliances;
         return _loc1_.GetAllCountByTempletID(this.FCostItemId);
      }
      
      public function get UserId() : String
      {
         var _loc1_:UInt64 = null;
         _loc1_ = new UInt64(SLogicsCore.Character.Identifier1,SLogicsCore.Character.Identifier0);
         return _loc1_.ToString();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount();
         if(!FIsResourcesLoadCompleted)
         {
            this.FProcessorWindowEmblem.Load();
            this.FUIEmblemPromptFrame.Load();
            return;
         }
         this.PacketPerform_CS_Emblem_Info();
      }
   }
}


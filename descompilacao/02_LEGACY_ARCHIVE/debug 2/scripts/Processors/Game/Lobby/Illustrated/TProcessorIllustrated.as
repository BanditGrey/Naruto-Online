package Processors.Game.Lobby.Illustrated
{
   import Components.Standard.TUITab;
   import Foundation.Common.THint;
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TArchiveSuper;
   import Logics.DatebaseVO.VO.TSystemLanguage;
   import Logics.SLogicsCore;
   import Logics.TransmigrationTrial.TTrialCampaign;
   import Processors.Game.Lobby.Common.TLobbyParameters;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindows;
   import Processors.Game.Lobby.Exercise.BaseActivity.Compoents.TUIBaseWindow;
   import Processors.Game.Lobby.Illustrated.Panel.TUIIllustratedAccessory;
   import Processors.Game.Lobby.Illustrated.Panel.TUIIllustratedChapterExchange;
   import Processors.Game.Lobby.Illustrated.Panel.TUIIllustratedNaruto;
   import Processors.Game.Lobby.Illustrated.Panel.TUIIllustratedPsychicBeast;
   import Processors.Game.Lobby.Illustrated.Panel.TUIIllustratedSuit;
   import Processors.Game.Lobby.Illustrated.Panel.TUIIllustratedTitle;
   import Processors.Game.Lobby.Illustrated.Panel.TUIIllustratedUpgradePrompt;
   import Processors.Game.Lobby.Illustrated.Panel.TUIIllustratedWing;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_MODULES;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.utils.ByteArray;
   
   public class TProcessorIllustrated extends TProcessorLobbyWindows
   {
      
      public static const TAB_COUNT:uint = 6;
      
      public static const ACTIVITY_REFERENCE:Vector.<Class> = Vector.<Class>([TUIIllustratedSuit,TUIIllustratedAccessory,TUIIllustratedPsychicBeast,TUIIllustratedTitle,TUIIllustratedNaruto,TUIIllustratedWing]);
      
      public static const SUB_UI:Vector.<String> = Vector.<String>(["MC_Suit","MC_Accessory","MC_PsychicBeast","MC_Title","MC_Naruto","MC_Wing"]);
      
      protected var FChapterExchange:TUIBaseWindow;
      
      protected var FPrompt:TUIIllustratedUpgradePrompt;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUIWindowVect:Vector.<TUIBaseWindow>;
      
      protected var FUITab:TUITab;
      
      protected var FChangeTabIndex:int;
      
      protected var FHelpTips:THint;
      
      protected var FMaskWidth:uint;
      
      public function TProcessorIllustrated(param1:TUIComponent, param2:TLobbyParameters)
      {
         super(param1,param2);
         TIllustratedModel.FIllustrated = SLogicsCore.Character.Illustrated;
         TIllustratedModel.FCharacter = SLogicsCore.Character;
         this.FChapterExchange = new TUIIllustratedChapterExchange(this);
         this.FPrompt = new TUIIllustratedUpgradePrompt(param1);
         this.FUITab = new TUITab(this);
         this.FUIWindowVect = new Vector.<TUIBaseWindow>(TAB_COUNT);
         this.FHelpTips = new THint();
         SetUIModuleID(CONST_MODULES.MODULE_Illustrated);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(4043309056);
         super.ResourcesPerform_UIRequest();
      }
      
      override public function Mount(param1:ByteArray = null) : void
      {
         super.Mount(param1);
         if(!FIsResourcesLoadCompleted)
         {
            this.FPrompt.Load();
            return;
         }
         this.UpdateUI();
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      override public function Unmount() : void
      {
         this.FChapterExchange.SetVisible(false);
         this.FPrompt.Visible = false;
         super.Unmount();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         var _loc2_:Class = null;
         this.FMC_Scene = TUtilityReflection.CreateDisplayObjectInstance("MC_IllustratedMain") as MovieClip;
         this.FMC_Scene.x = (FUICore.StageWidth - this.FMC_Scene.width) / 2;
         this.FMC_Scene.y = (FUICore.StageHeight - this.FMC_Scene.height) / 2;
         this.addChild(this.FMC_Scene);
         var _loc1_:int = 0;
         while(_loc1_ < TAB_COUNT)
         {
            _loc2_ = ACTIVITY_REFERENCE[_loc1_];
            this.FUIWindowVect[_loc1_] = new _loc2_(this);
            this.FUIWindowVect[_loc1_].Perform_UIDispatch(this.FMC_Scene[SUB_UI[_loc1_]]);
            this.FUIWindowVect[_loc1_].OnGetBox = ProcessorOnGetBoxClick;
            this.FUIWindowVect[_loc1_].OnBuyBox = ProcessorOnBuyBoxClick;
            this.FUIWindowVect[_loc1_].OnItemOver = UIComponentsHintOnOver;
            this.FUIWindowVect[_loc1_].OnItemOut = UIComponentsHintOnOut;
            this.FUIWindowVect[_loc1_].OnShowHtmlTip = ProcessorOnShowHtmlText;
            this.FUIWindowVect[_loc1_].OnHideHtmlTip = ProcessorOnHideHtmlText;
            this.FUIWindowVect[_loc1_].OnGoto = this.ProcessorOnGotoStage;
            _loc1_++;
         }
         this.FChapterExchange.OnItemOver = UIComponentsHintOnOver;
         this.FChapterExchange.OnItemOut = UIComponentsHintOnOut;
         this.FChapterExchange.Perform_UIDispatch(this.FMC_Scene["MC_ChapterExchange"]);
         this.FChapterExchange.SetVisible(false);
         _loc1_ = 0;
         while(_loc1_ < TAB_COUNT)
         {
            this.FUITab.SetTabByIndex(this.FMC_Scene["BTN_Tab" + _loc1_],_loc1_);
            _loc1_++;
         }
         this.FUITab.OnSwitch = this.TabOnSwitch;
         this.FUITab.Init();
         this.FMaskWidth = this.FMC_Scene["MC_Bar"]["MC_Mask"].width;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function PacketRegisterRoutines() : void
      {
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Illustrated_LoadInfoRet,this.ProcessorOnLoadInfoRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Illustrated_UpgradeRet,this.ProcessorOnUpgradeRet);
         FPacketRoutines.Register(CONST_NETWORK.PACKETID_SC_Illustrated_ExchangeRet,this.ProcessorOnExchangeRet);
         super.PacketRegisterRoutines();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
         if(FIsResourcesLoadCompleted == false || Visible == false)
         {
            return;
         }
         if(Boolean(this.FMC_Scene) && this.FMC_Scene.visible)
         {
            this.FUIWindowVect[this.FChangeTabIndex].LogicsPerform();
            if(Boolean(this.FChapterExchange) && this.FChapterExchange.Visible)
            {
               this.FChapterExchange.LogicsPerform();
            }
         }
      }
      
      protected function TabOnSwitch(param1:Object) : void
      {
         this.FChangeTabIndex = param1 as int;
         this.UpdateUI();
      }
      
      protected function ProcessorOnGotoStage(param1:int, param2:TTrialCampaign = null) : void
      {
         this.UpdateUI();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FMC_Scene["BTN_Close"].addEventListener(MouseEvent.CLICK,this.OnWindowClose);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OVER,this.ButtonHelpOnOver);
         this.FMC_Scene["BTN_Help"].addEventListener(MouseEvent.MOUSE_OUT,this.ButtonHelpOnOut);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_ChapterExchange,true);
         this.FMC_Scene.BTN_ChapterExchange.addEventListener(MouseEvent.CLICK,this.OnChapterExchangeClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_ChapterUpgrade,true);
         this.FMC_Scene.BTN_ChapterUpgrade.addEventListener(MouseEvent.CLICK,this.OnChapterUpgradeClick);
         TGameUtil.setButtonMode(this.FMC_Scene.BTN_GoldUpgrade,true);
         this.FMC_Scene.BTN_GoldUpgrade.addEventListener(MouseEvent.CLICK,this.OnGoldUpgradeClick);
         super.ResourcesPerform_UILocations();
      }
      
      protected function OnWindowClose(param1:MouseEvent) : void
      {
         ProcessorClose();
      }
      
      protected function ButtonHelpOnOver(param1:MouseEvent) : void
      {
         var _loc2_:TSystemLanguage = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_SystemLanguage,CONST_SYSTEMLANGUAGE.HELPTIPS_70170110) as TSystemLanguage;
         this.FHelpTips.Content = _loc2_.Desc;
         UIHelpTipsHintOnOver(this,this.FHelpTips);
      }
      
      protected function ButtonHelpOnOut(param1:MouseEvent) : void
      {
         UIHelpTipsHintOnOut(this);
      }
      
      protected function UpdateUI() : void
      {
         var _loc9_:Array = null;
         var _loc10_:TArchiveSuper = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < TAB_COUNT)
         {
            if(_loc1_ == this.FChangeTabIndex)
            {
               this.FUIWindowVect[_loc1_].SetVisible(true);
               this.FUIWindowVect[_loc1_].UpdateUI();
            }
            else
            {
               this.FUIWindowVect[_loc1_].SetVisible(false);
            }
            _loc1_++;
         }
         var _loc2_:Object = TIllustratedModel.IllustratedLevel(TIllustratedModel.FIllustrated.IllustratedExp);
         this.FMC_Scene["TF_Level"].text = TIllustratedModel.TextFormat(70470010,_loc2_.Level);
         this.FMC_Scene["TF_EXP"].text = TIllustratedModel.TextFormat(70470011,_loc2_.Exp,_loc2_.MaxExp);
         this.FMC_Scene["MC_Bar"]["MC_Mask"].width = _loc2_.Exp / _loc2_.MaxExp * this.FMaskWidth;
         this.FMC_Scene["TF_Chapter"].text = TIllustratedModel.TextFormat(70470001,TIllustratedModel.FIllustrated.ChapterCount);
         var _loc3_:Array = TIllustratedModel.ActivationAddAttribute(this.FChangeTabIndex + 1);
         var _loc4_:Array = [];
         var _loc5_:int = int(_loc3_.length);
         this.FMC_Scene["TF_Activate"].text = TIllustratedModel.TextFormat(70470002,_loc5_);
         this.FMC_Scene["TF_Activate_Desc"].text = TIllustratedModel.TextFormat(70470007 + (this.FChangeTabIndex >= 3 ? this.FChangeTabIndex + 4 : this.FChangeTabIndex));
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            _loc9_ = TIllustratedModel.IllustratedAddAttribute(_loc3_[_loc1_]);
            _loc4_ = TIllustratedModel.MergeAddAttribute(_loc4_,_loc9_);
            _loc1_++;
         }
         _loc3_ = [];
         _loc5_ = TIllustratedModel.ArchiveSuper.Count;
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            _loc10_ = TIllustratedModel.ArchiveSuper.GetDatebaseByIndex(_loc1_) as TArchiveSuper;
            if(_loc10_.Type == this.FChangeTabIndex + 1)
            {
               _loc3_.push(_loc10_);
            }
            _loc1_++;
         }
         _loc5_ = int(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            _loc10_ = _loc3_[_loc1_];
            _loc11_ = int(_loc10_.AddAttributeVector.length);
            this.FMC_Scene["MC_BonusAttribute_" + _loc1_]["TF_Number"].text = _loc10_.ActivationNum;
            this.FMC_Scene["MC_BonusAttribute_" + _loc1_]["TF_Value"].text = TIllustratedModel.AttributeFormat(_loc10_.AddAttributeVector[0][0],_loc10_.AddAttributeVector[0][1]);
            _loc12_ = 1;
            while(_loc12_ < _loc11_)
            {
               this.FMC_Scene["MC_BonusAttribute_" + _loc1_]["TF_Value"].text += "  " + TIllustratedModel.AttributeFormat(_loc10_.AddAttributeVector[_loc12_][0],_loc10_.AddAttributeVector[_loc12_][1]);
               _loc12_++;
            }
            this.FMC_Scene["MC_BonusAttribute_" + _loc1_]["TF_Number"].textColor = this.FMC_Scene["MC_BonusAttribute_" + _loc1_]["TF_Value"].textColor = TIllustratedModel.ActivationAddAttribute(this.FChangeTabIndex + 1).length >= _loc10_.ActivationNum ? 15518068 : 10066329;
            _loc1_++;
         }
         _loc3_ = TIllustratedModel.ActivationTotalAttribute();
         _loc4_ = [];
         _loc5_ = int(_loc3_.length);
         _loc1_ = 0;
         while(_loc1_ < _loc5_)
         {
            _loc9_ = TIllustratedModel.IllustratedAddAttribute(_loc3_[_loc1_]);
            _loc4_ = TIllustratedModel.MergeAddAttribute(_loc4_,_loc9_);
            _loc1_++;
         }
         var _loc6_:int = 0;
         if(_loc2_.Level > 0)
         {
            _loc6_ = int(TIllustratedModel.ArchiveUpgrade.GetDatebaseByIndex(_loc2_.Level - 1)["AddAttribute"]);
         }
         var _loc7_:int = 0;
         if(_loc2_.Level < TIllustratedModel.ArchiveUpgrade.Count)
         {
            _loc7_ = int(TIllustratedModel.ArchiveUpgrade.GetDatebaseByIndex(_loc2_.Level)["AddAttribute"]);
         }
         var _loc8_:Array = [16,17,20,21,11,101];
         _loc1_ = 0;
         while(_loc1_ < 6)
         {
            this.FMC_Scene["MC_Attribute_" + _loc1_]["TF_Attribute"].text = TIllustratedModel.AttributeFormat(_loc8_[_loc1_],0);
            this.FMC_Scene["MC_Attribute_" + _loc1_]["TF_BeforeValue"].text = "0";
            this.FMC_Scene["MC_Attribute_" + _loc1_]["TF_AfterValue"].text = "";
            for each(_loc9_ in _loc4_)
            {
               if(_loc9_[0] == _loc8_[_loc1_])
               {
                  this.FMC_Scene["MC_Attribute_" + _loc1_]["TF_BeforeValue"].text = int(_loc9_[1] * (1 + _loc6_ / 10000));
                  if(_loc7_ > 0)
                  {
                     this.FMC_Scene["MC_Attribute_" + _loc1_]["TF_AfterValue"].text = "-> " + int(_loc9_[1] * (1 + _loc7_ / 10000));
                  }
                  else
                  {
                     this.FMC_Scene["MC_Attribute_" + _loc1_]["TF_AfterValue"].text = "";
                  }
                  break;
               }
            }
            _loc1_++;
         }
      }
      
      protected function PerformPacket_CS_LoadInfoReq() : void
      {
         var _loc1_:TPacket = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_Illustrated_LoadInfoReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc1_);
      }
      
      private function ProcessorOnLoadInfoRet(param1:TPacket) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         TIllustratedModel.FIllustrated.ChapterCount = _loc2_.readUnsignedInt();
         TIllustratedModel.FIllustrated.IllustratedExp = _loc2_.readUnsignedInt();
         TIllustratedModel.FIllustrated.ChapterUpgradeCount = _loc2_.readUnsignedInt();
         TIllustratedModel.FIllustrated.GoldUpgradeCount = _loc2_.readUnsignedInt();
         TIllustratedModel.FIllustrated.IllustratedInfo.length = 0;
         _loc4_ = _loc2_.readShort();
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc6_ = {};
            _loc6_.ID = _loc2_.readUnsignedInt();
            _loc6_.Type = TIllustratedModel.IllustratedType(_loc6_.ID);
            _loc6_.Parts = [];
            _loc7_ = _loc2_.readShort();
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc6_.Parts.push(_loc2_.readUnsignedInt());
               _loc8_++;
            }
            TIllustratedModel.FIllustrated.IllustratedInfo.push(_loc6_);
            _loc5_++;
         }
         if(FIsResourcesLoadCompleted && this.visible)
         {
            this.UpdateUI();
            if(this.FChapterExchange.Visible)
            {
               this.FChapterExchange.SetVisible(false);
               this.FChapterExchange.SetVisible(true);
            }
         }
      }
      
      private function ProcessorOnUpgradeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      private function ProcessorOnExchangeRet(param1:TPacket) : void
      {
         var _loc2_:ByteArray = param1.Data;
         var _loc3_:int = _loc2_.readInt();
         if(_loc3_ != 0)
         {
            EffectGenerateTextByErrorCode(_loc3_);
            OnClose(this);
            return;
         }
         this.FChapterExchange["PlayEffect"]();
         this.PerformPacket_CS_LoadInfoReq();
      }
      
      private function OnChapterExchangeClick(param1:MouseEvent) : void
      {
         this.FChapterExchange.SetVisible(true);
      }
      
      private function OnChapterUpgradeClick(param1:MouseEvent) : void
      {
         if(TIllustratedModel.FIllustrated.ChapterCount >= TIllustratedModel.ArchiveCofig.GetDatebaseByIndex(0)["Cost"])
         {
            this.FPrompt.ShowPrompt(1,null);
         }
         else
         {
            EffectGenerateTextByErrorCode(21);
         }
      }
      
      private function OnGoldUpgradeClick(param1:MouseEvent) : void
      {
         if(TIllustratedModel.ArchiveCofig.Count - TIllustratedModel.FIllustrated.GoldUpgradeCount > 1)
         {
            if(TIllustratedModel.FCharacter.CreditGold >= TIllustratedModel.ArchiveCofig.GetDatebaseByIndex(TIllustratedModel.FIllustrated.GoldUpgradeCount + 1)["Cost"])
            {
               this.FPrompt.ShowPrompt(2,null);
            }
            else
            {
               EffectGenerateTextByErrorCode(56);
            }
         }
         else
         {
            EffectGenerateTextByErrorCode(725);
         }
      }
   }
}


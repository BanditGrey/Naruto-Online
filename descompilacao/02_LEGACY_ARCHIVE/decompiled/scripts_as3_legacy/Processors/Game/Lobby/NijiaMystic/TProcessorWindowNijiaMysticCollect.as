package Processors.Game.Lobby.NijiaMystic
{
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
   import Logics.DatebaseVO.VO.TMysticCollect;
   import Logics.NijiaMystic.TNijiaMysticData;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.TreasureMap.ConsumeFrame;
   import Processors.Game.Windows.Information.TUIWindowConfirmation;
   import Rendering.Overlayers.Hints.TOverlayerHint;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Constants.CONST_NIJIAMYSTIC;
   import Resources.Constants.CONST_SYSTEMLANGUAGE;
   import Resources.Strings.STRING_COMMON;
   import Resources.Strings.STRING_NIJIAMYSTIC;
   import Utilities.UI.Overlayers.TUtilityUIOverlayer;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import ghostcat.util.easing.*;
   
   public class TProcessorWindowNijiaMysticCollect extends TUIComponent
   {
      
      protected static const MAX_MATERIAL:uint = 9;
      
      protected static const MAX_MYSTIC:uint = 8;
      
      protected static const TYPE_MakeMateria_Normal:uint = 1;
      
      protected static const TYPE_MakeMateria_Adv:uint = 2;
      
      protected static const TYPE_MakeMateria_Max:uint = 3;
      
      protected var FScene:MovieClip;
      
      protected var FMC_EffectLeft:MovieClip;
      
      protected var FMC_EffectRight:MovieClip;
      
      protected var FBtn_GotoUpgrade:SimpleButton;
      
      protected var FBtn_Make:MovieClip;
      
      protected var FBtn_AdvMake:MovieClip;
      
      protected var FBtn_MaxMake:MovieClip;
      
      protected var FBtn_Collect:MovieClip;
      
      protected var FBtn_Reset:MovieClip;
      
      protected var FTF_ResetCount:TextField;
      
      protected var FTF_MaterialVect:Vector.<TextField>;
      
      protected var FMC_MaterialEffectVect:Vector.<MovieClip>;
      
      protected var FMC_MaterialVect:Vector.<MovieClip>;
      
      protected var FTF_MaterialLvVect:Vector.<TextField>;
      
      protected var FNijiaMysticData:TNijiaMysticData;
      
      protected var FNijiaMysticCollectBins:TBins;
      
      protected var FHint:THint;
      
      protected var FOverlayerHint:TOverlayerHint;
      
      protected var FMaxFreeResetTimes:uint;
      
      protected var FResetCostVect:Vector.<uint>;
      
      protected var FMakeCost:uint;
      
      protected var FAdvMakeCost:uint;
      
      protected var FMaxMakeCost:uint;
      
      protected var FAdvConfirmation:TUIWindowConfirmation;
      
      protected var FMaxConfirmation:TUIWindowConfirmation;
      
      protected var FResetConfirmation:TUIWindowConfirmation;
      
      protected var FFreeBoomEffect:Vector.<MovieClip>;
      
      protected var FLiveBoomEffect:Vector.<MovieClip>;
      
      protected var FCollectWaitTextEffect:Boolean;
      
      protected var FGotoUpgrage:Function;
      
      protected var FEffectGenerateText:Function;
      
      public function TProcessorWindowNijiaMysticCollect(param1:TUIComponent)
      {
         super(param1);
         this.FNijiaMysticData = SLogicsCore.NijiaMysticData;
         this.FTF_MaterialVect = new Vector.<TextField>(MAX_MATERIAL);
         this.FMC_MaterialEffectVect = new Vector.<MovieClip>(MAX_MATERIAL);
         this.FMC_MaterialVect = new Vector.<MovieClip>(MAX_MYSTIC);
         this.FTF_MaterialLvVect = new Vector.<TextField>(MAX_MYSTIC);
         this.FFreeBoomEffect = new Vector.<MovieClip>();
         this.FLiveBoomEffect = new Vector.<MovieClip>();
         this.FHint = new THint();
      }
      
      protected function InitResource() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TConfigValue = null;
         this.FMC_EffectLeft = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_EffectLeft];
         this.FMC_EffectRight = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_MC_EffectRight];
         this.FBtn_GotoUpgrade = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_GotoUpgrade];
         this.FBtn_GotoUpgrade.addEventListener(MouseEvent.CLICK,this.OnGotoUpgrage);
         this.FBtn_Make = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_Make];
         this.FBtn_AdvMake = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_AdvMake];
         this.FBtn_MaxMake = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_MaxMake];
         this.FBtn_Collect = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_Collect];
         this.FBtn_Reset = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_Reset];
         TGameUtil.setButtonMode(this.FBtn_Make,true);
         TGameUtil.setButtonMode(this.FBtn_AdvMake,true);
         TGameUtil.setButtonMode(this.FBtn_MaxMake,true);
         TGameUtil.setButtonMode(this.FBtn_Collect,true);
         TGameUtil.setButtonMode(this.FBtn_Reset,true);
         this.FBtn_Make.addEventListener(MouseEvent.CLICK,this.OnMakeMateriaClick);
         this.FBtn_Make.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMateriaMove);
         this.FBtn_Make.addEventListener(MouseEvent.MOUSE_OUT,this.OnMateriaOut);
         this.FBtn_AdvMake.addEventListener(MouseEvent.CLICK,this.OnAdvMakeMateriaClick);
         this.FBtn_AdvMake.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMateriaMove);
         this.FBtn_AdvMake.addEventListener(MouseEvent.MOUSE_OUT,this.OnMateriaOut);
         this.FBtn_MaxMake.addEventListener(MouseEvent.CLICK,this.OnMaxMakeMateriaClick);
         this.FBtn_MaxMake.addEventListener(MouseEvent.MOUSE_MOVE,this.OnMateriaMove);
         this.FBtn_MaxMake.addEventListener(MouseEvent.MOUSE_OUT,this.OnMateriaOut);
         this.FBtn_Collect.addEventListener(MouseEvent.CLICK,this.OnCollectClick);
         this.FBtn_Reset.addEventListener(MouseEvent.CLICK,this.OnResetClick);
         this.FTF_ResetCount = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_TF_ResetCount];
         _loc1_ = 0;
         while(_loc1_ < MAX_MATERIAL)
         {
            _loc2_ = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_Material + _loc1_];
            _loc2_[CONST_NIJIAMYSTIC.RESOURCE_MC_Icon].gotoAndStop(_loc1_ + 1);
            this.FTF_MaterialVect[_loc1_] = _loc2_[CONST_NIJIAMYSTIC.RESOURCE_TF_Count];
            this.FMC_MaterialEffectVect[_loc1_] = _loc2_[CONST_NIJIAMYSTIC.RESOURCE_MC_Icon][CONST_NIJIAMYSTIC.RESOURCE_MC_Effect];
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < MAX_MYSTIC)
         {
            this.FMC_MaterialVect[_loc1_] = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_BTN_Mystic + _loc1_];
            this.FTF_MaterialLvVect[_loc1_] = this.FScene[CONST_NIJIAMYSTIC.RESOURCE_TF_Mystic + _loc1_];
            _loc1_++;
         }
         this.FNijiaMysticCollectBins = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_NijiaMysticCollect);
         this.FOverlayerHint = new TOverlayerHint(this.Parent.Parent);
         this.FOverlayerHint.visible = false;
         TUtilityUIOverlayer.ResourcesDispatch(this.FOverlayerHint);
         this.FAdvConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FAdvConfirmation);
         this.FAdvConfirmation.x = (FUICore.StageWidth - this.FAdvConfirmation.WindowWidth) / 2;
         this.FAdvConfirmation.y = (FUICore.StageHeight - this.FAdvConfirmation.WindowHeight) / 2;
         this.FAdvConfirmation.SetCheckBox(true);
         this.FMaxConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FMaxConfirmation);
         this.FMaxConfirmation.x = (FUICore.StageWidth - this.FMaxConfirmation.WindowWidth) / 2;
         this.FMaxConfirmation.y = (FUICore.StageHeight - this.FMaxConfirmation.WindowHeight) / 2;
         this.FMaxConfirmation.SetCheckBox(true);
         this.FResetConfirmation = new TUIWindowConfirmation(this.Parent.Parent);
         TUtilityUIWindow.SetupWindowConfirmation(this.FResetConfirmation);
         this.FResetConfirmation.x = (FUICore.StageWidth - this.FResetConfirmation.WindowWidth) / 2;
         this.FResetConfirmation.y = (FUICore.StageHeight - this.FResetConfirmation.WindowHeight) / 2;
         this.FResetConfirmation.SetCheckBox(true);
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.MYSTIC_ResetCost) as TConfigValue;
         this.FResetCostVect = _loc3_.Value as Vector.<uint>;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.MYSTIC_MakeCost) as TConfigValue;
         this.FMakeCost = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.MYSTIC_AdvMakeCost) as TConfigValue;
         this.FAdvMakeCost = _loc3_.Value as uint;
         _loc3_ = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.MYSTIC_MaxMakeCost) as TConfigValue;
         this.FMaxMakeCost = _loc3_.Value as uint;
         this.FMaxFreeResetTimes = 0;
         _loc1_ = 0;
         while(_loc1_ < this.FResetCostVect.length)
         {
            if(this.FResetCostVect[_loc1_] == 0)
            {
               ++this.FMaxFreeResetTimes;
            }
            _loc1_++;
         }
      }
      
      protected function IsEmpetCantMake() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TMysticCollect = null;
         _loc2_ = this.FNijiaMysticData.RefreshMaterialVect.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FNijiaMysticData.RefreshMaterialVect[_loc1_];
            _loc4_ = this.FNijiaMysticCollectBins.GetDatebaseByIdentifier(_loc3_) as TMysticCollect;
            if(_loc4_ == null)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function IsCanMakeMateria() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TMysticCollect = null;
         _loc2_ = this.FNijiaMysticData.RefreshMaterialVect.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FNijiaMysticData.RefreshMaterialVect[_loc1_];
            _loc4_ = this.FNijiaMysticCollectBins.GetDatebaseByIdentifier(_loc3_) as TMysticCollect;
            if(_loc4_.CollectLv < 10)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function IsCanAdvMakeMateria() : Boolean
      {
         return this.IsCanMakeMateria();
      }
      
      protected function IsCanMaxMakeMateria() : Boolean
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:TMysticCollect = null;
         _loc2_ = this.FNijiaMysticData.RefreshMaterialVect.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FNijiaMysticData.RefreshMaterialVect[_loc1_];
            _loc4_ = this.FNijiaMysticCollectBins.GetDatebaseByIdentifier(_loc3_) as TMysticCollect;
            if(_loc4_.CollectLv < 10 || _loc4_.CollectKey != 0)
            {
               return true;
            }
            _loc1_++;
         }
         return false;
      }
      
      protected function GetBoomEffect() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(this.FFreeBoomEffect.length <= 0)
         {
            _loc1_ = TUtilityReflection.CreateDisplayObjectInstance(CONST_NIJIAMYSTIC.RESOURCE_ClassName_NijiaMystic_Effect) as MovieClip;
            this.FScene.addChild(_loc1_);
         }
         else
         {
            _loc1_ = this.FFreeBoomEffect.pop();
         }
         return _loc1_;
      }
      
      protected function OnGotoUpgrage(param1:MouseEvent) : void
      {
         if(this.FGotoUpgrage != null)
         {
            this.FGotoUpgrage(this);
         }
      }
      
      protected function OnMakeMateriaClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         if(this.IsEmpetCantMake())
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_NIJIAMYSTIC.STRING_CantEveryMake);
            }
            return;
         }
         if(!this.IsCanMakeMateria())
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_NIJIAMYSTIC.STRING_CantMake);
            }
            return;
         }
         if(SLogicsCore.Character.CreditSilverCoin.ToNumber() < this.FMakeCost)
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_COMMON.NOTENOUGH_Coin);
            }
            return;
         }
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_MakeReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(TYPE_MakeMateria_Normal);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.SetButtonStatus(false);
      }
      
      protected function OnAdvMakeMateriaClick(param1:MouseEvent) : void
      {
         if(this.IsEmpetCantMake())
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_NIJIAMYSTIC.STRING_CantEveryMake);
            }
            return;
         }
         if(!this.IsCanAdvMakeMateria())
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_NIJIAMYSTIC.STRING_CantAdvMake);
            }
            return;
         }
         if(SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate < this.FAdvMakeCost)
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         if(!this.FAdvConfirmation.IsSelected)
         {
            this.FAdvConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Mystic_AdvMake).DescribeString,this.FAdvMakeCost);
            this.FAdvConfirmation.visible = true;
            this.FAdvConfirmation.OnOK = this.SureAdvMakeMateriaOk;
         }
         else
         {
            this.SureAdvMakeMateriaOk(this);
         }
      }
      
      protected function SureAdvMakeMateriaOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_MakeReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(TYPE_MakeMateria_Adv);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.SetButtonStatus(false);
      }
      
      protected function OnMaxMakeMateriaClick(param1:MouseEvent) : void
      {
         if(this.IsEmpetCantMake())
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_NIJIAMYSTIC.STRING_CantEveryMake);
            }
            return;
         }
         if(!this.IsCanMaxMakeMateria())
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_NIJIAMYSTIC.STRING_CantMaxMake);
            }
            return;
         }
         if(SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate < this.FMaxMakeCost)
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         if(!this.FMaxConfirmation.IsSelected)
         {
            this.FMaxConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Mystic_MaxMake).DescribeString,this.FMaxMakeCost);
            this.FMaxConfirmation.visible = true;
            this.FMaxConfirmation.OnOK = this.SureMaxMakeMateriaOk;
         }
         else
         {
            this.SureMaxMakeMateriaOk(this);
         }
      }
      
      protected function SureMaxMakeMateriaOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         var _loc3_:ByteArray = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_MakeReq);
         _loc3_ = _loc2_.Data;
         _loc3_.writeUnsignedInt(TYPE_MakeMateria_Max);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.SetButtonStatus(false);
      }
      
      protected function OnCollectClick(param1:MouseEvent) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_CollectReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.SetButtonVisible(false);
         this.FCollectWaitTextEffect = true;
      }
      
      protected function OnResetClick(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         _loc2_ = this.FResetCostVect[Math.min(this.FNijiaMysticData.FlushTimes,this.FResetCostVect.length - 1)];
         if(_loc2_ <= 0)
         {
            this.SureResetOk(this);
            return;
         }
         if(SLogicsCore.Character.CreditGold + SLogicsCore.Character.CreditGiftCertificate < _loc2_)
         {
            if(this.FEffectGenerateText != null)
            {
               this.FEffectGenerateText(STRING_COMMON.NOTENOUGH_Gold);
            }
            return;
         }
         if(!this.FResetConfirmation.IsSelected)
         {
            this.FResetConfirmation.Text = TUtilityString.Format(new ConsumeFrame(CONST_SYSTEMLANGUAGE.ConsumerConfirm_Mystic_Reset).DescribeString,_loc2_);
            this.FResetConfirmation.visible = true;
            this.FResetConfirmation.OnOK = this.SureResetOk;
         }
         else
         {
            this.SureResetOk(this);
         }
      }
      
      protected function SureResetOk(param1:Object) : void
      {
         var _loc2_:TPacket = null;
         _loc2_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_NijiaMystic_CollectResetReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc2_);
         this.SetButtonVisible(false);
      }
      
      protected function OnMateriaMove(param1:MouseEvent) : void
      {
         if(param1.target == this.FBtn_Make)
         {
            this.FHint.Caption = TUtilityString.Format(STRING_NIJIAMYSTIC.FORMAT_MysticMake,this.FMakeCost);
         }
         else if(param1.target == this.FBtn_AdvMake)
         {
            this.FHint.Caption = TUtilityString.Format(STRING_NIJIAMYSTIC.FORMAT_MysticAdvMake,this.FAdvMakeCost);
         }
         else if(param1.target == this.FBtn_MaxMake)
         {
            this.FHint.Caption = TUtilityString.Format(STRING_NIJIAMYSTIC.FORMAT_MysticMaxMake,this.FMaxMakeCost);
         }
         this.FOverlayerHint.Context = this.FHint;
         this.FOverlayerHint.Render(FUICore.MouseCoordinate);
         this.FOverlayerHint.Show();
      }
      
      protected function OnMateriaOut(param1:MouseEvent) : void
      {
         this.FOverlayerHint.Hide();
      }
      
      public function get GotoUpgrage() : Function
      {
         return this.FGotoUpgrage;
      }
      
      public function set GotoUpgrage(param1:Function) : void
      {
         this.FGotoUpgrage = param1;
      }
      
      public function get EffectGenerateText() : Function
      {
         return this.FEffectGenerateText;
      }
      
      public function set EffectGenerateText(param1:Function) : void
      {
         this.FEffectGenerateText = param1;
      }
      
      public function SetScene(param1:MovieClip) : void
      {
         this.FScene = param1;
         addChild(this.FScene);
         this.InitResource();
      }
      
      public function UpdataUI() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:MovieClip = null;
         var _loc3_:TextField = null;
         var _loc4_:TMysticCollect = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:String = null;
         var _loc9_:Boolean = false;
         this.FTF_ResetCount.text = String(Math.max(this.FMaxFreeResetTimes - this.FNijiaMysticData.FlushTimes,0));
         _loc8_ = STRING_NIJIAMYSTIC.STRING_REWARD;
         _loc1_ = 0;
         while(_loc1_ < MAX_MATERIAL)
         {
            _loc7_ = this.FNijiaMysticData.MysticPointVect[_loc1_];
            _loc6_ = uint(int(this.FTF_MaterialVect[_loc1_].text));
            if(_loc6_ != _loc7_)
            {
               this.FMC_MaterialEffectVect[_loc1_].gotoAndPlay(1);
            }
            this.FTF_MaterialVect[_loc1_].text = String(_loc7_);
            if(this.FCollectWaitTextEffect)
            {
               if(_loc7_ > _loc6_)
               {
                  _loc8_ += "\t" + STRING_NIJIAMYSTIC.STRING_MaterialName[_loc1_] + "*" + (_loc7_ - _loc6_) + "\n";
               }
            }
            _loc1_++;
         }
         if(this.FCollectWaitTextEffect)
         {
            this.FEffectGenerateText(_loc8_);
            this.FCollectWaitTextEffect = false;
         }
         _loc9_ = false;
         _loc1_ = 0;
         while(_loc1_ < MAX_MYSTIC)
         {
            _loc2_ = this.FMC_MaterialVect[_loc1_];
            _loc3_ = this.FTF_MaterialLvVect[_loc1_];
            _loc5_ = this.FNijiaMysticData.RefreshMaterialVect[_loc1_];
            if(_loc5_ != 0)
            {
               _loc2_.visible = true;
               _loc3_.visible = true;
               _loc4_ = this.FNijiaMysticCollectBins.GetDatebaseByIdentifier(_loc5_) as TMysticCollect;
               _loc2_.gotoAndStop(_loc4_.CollectKey + 1);
               _loc2_.scaleX = _loc2_.scaleY = 0.5 + 0.05 * _loc4_.CollectLv;
               _loc3_.text = TUtilityString.Format(STRING_NIJIAMYSTIC.FORMAT_MysticLevel,_loc4_.CollectLv);
               _loc9_ = true;
            }
            else
            {
               _loc2_.visible = false;
               _loc3_.visible = false;
            }
            _loc1_++;
         }
         if(!_loc9_)
         {
            this.FBtn_Collect.visible = false;
            this.FBtn_Reset.visible = true;
         }
         else
         {
            this.FBtn_Collect.visible = true;
            this.FBtn_Reset.visible = false;
         }
      }
      
      public function Update() : void
      {
      }
      
      override public function set Visible(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         super.Visible = param1;
         if(this.FMC_EffectLeft != null)
         {
            this.FMC_EffectLeft.play();
         }
         if(this.FMC_EffectRight != null)
         {
            this.FMC_EffectRight.play();
         }
         if(this.FScene != null)
         {
            _loc2_ = 0;
            while(_loc2_ < MAX_MYSTIC)
            {
               _loc3_ = this.FMC_MaterialVect[_loc2_];
               if(param1)
               {
                  _loc3_[CONST_NIJIAMYSTIC.RESOURCE_MC_Material][CONST_NIJIAMYSTIC.RESOURCE_MC_MaterialEffect].play();
               }
               else
               {
                  _loc3_[CONST_NIJIAMYSTIC.RESOURCE_MC_Material][CONST_NIJIAMYSTIC.RESOURCE_MC_MaterialEffect].stop();
               }
               _loc2_++;
            }
         }
      }
      
      public function SetButtonStatus(param1:Boolean) : void
      {
         TGameUtil.setButtonMode(this.FBtn_Make,param1);
         TGameUtil.setButtonMode(this.FBtn_AdvMake,param1);
         TGameUtil.setButtonMode(this.FBtn_MaxMake,param1);
      }
      
      public function ShowBoom() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:MovieClip = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         _loc2_ = this.FNijiaMysticData.BoomVect.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc5_ = this.FNijiaMysticData.BoomVect[_loc1_];
            _loc6_ = (_loc5_ + 1) % MAX_MYSTIC;
            _loc7_ = (_loc5_ + MAX_MYSTIC - 1) % MAX_MYSTIC;
            _loc3_ = this.GetBoomEffect();
            _loc4_ = this.GetBoomEffect();
            _loc3_.mc_effect.play();
            _loc4_.mc_effect.play();
            _loc3_.visible = true;
            _loc4_.visible = true;
            _loc3_.x = _loc4_.x = this.FMC_MaterialVect[_loc5_].x;
            _loc3_.y = _loc4_.y = this.FMC_MaterialVect[_loc5_].y - 30;
            this.FLiveBoomEffect.push(_loc3_);
            this.FLiveBoomEffect.push(_loc4_);
            TweenUtil.to(_loc3_,700,{
               "x":this.FMC_MaterialVect[_loc6_].x,
               "y":this.FMC_MaterialVect[_loc6_].y - 30,
               "onComplete":this.BoomMoveEnd,
               "ease":Cubic.easeOut
            });
            TweenUtil.to(_loc4_,700,{
               "x":this.FMC_MaterialVect[_loc7_].x,
               "y":this.FMC_MaterialVect[_loc7_].y - 30,
               "onComplete":this.BoomMoveEnd,
               "ease":Cubic.easeOut
            });
            _loc1_++;
         }
      }
      
      public function SetButtonVisible(param1:Boolean) : void
      {
         if(this.FBtn_Reset != null)
         {
            this.FBtn_Reset.visible = param1;
            this.FBtn_Collect.visible = param1;
         }
      }
      
      public function BoomMoveEnd() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         var _loc3_:MovieClip = null;
         _loc2_ = this.FLiveBoomEffect.length;
         _loc1_ = 0;
         while(_loc1_ < _loc2_)
         {
            _loc3_ = this.FLiveBoomEffect.pop();
            _loc3_.visible = false;
            _loc3_.mc_effect.stop();
            this.FFreeBoomEffect.push(_loc3_);
            _loc1_++;
         }
      }
   }
}


package Processors.Game.Lobby.CopyClassroom
{
   import Foundation.Network.SNetworkCore;
   import Foundation.Network.TPacket;
   import Foundation.Resources.Bins.TBins;
   import Foundation.Resources.SResourcesCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Foundation.Utilities.TUtilityString;
   import Logics.Characters.TCharacter;
   import Logics.DatebaseVO.VO.TConfigValue;
   import Logics.DatebaseVO.VO.TVipConfig;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Processors.Game.Windows.Information.TUIWindowRecharge;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_CONFIGVALUE;
   import Resources.Constants.CONST_COPYCLASSROOM;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Constants.CONST_NETWORK;
   import Resources.Strings.STRING_COPYCLASSROOM;
   import Utilities.UI.Windows.TUtilityUIWindow;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TProcessorWindowCopypingBuy extends TProcessorLobbyWindow
   {
      
      protected var FMC:Sprite;
      
      protected var FBtn_Ok:MovieClip;
      
      protected var FBtn_Close:MovieClip;
      
      protected var FTF_CostGold:TextField;
      
      protected var FTF_BuyTimesPrompt:TextField;
      
      protected var FConfigValueBin:TBins;
      
      protected var FVipConfigBin:TBins;
      
      protected var FConfigValue:TConfigValue;
      
      protected var FTotalCanBuyCount:int;
      
      protected var FCostGold:Vector.<uint>;
      
      protected var FAlreadyBuyCount:uint;
      
      protected var FUIWindowRecharge:TUIWindowRecharge;
      
      public function TProcessorWindowCopypingBuy(param1:TUIComponent)
      {
         super(param1);
      }
      
      override protected function ResourcesPerform_UIRequest() : void
      {
         SResourcesCore.TexturesSwfLobby.LoadPrimary(CONST_COPYCLASSROOM.RESOURCESID_Swf_COPYCLASSROOM);
         this.FUIWindowRecharge = new TUIWindowRecharge(this.Parent);
         this.FUIWindowRecharge.x = (CONST_COMMON.STAGE_Width - this.FUIWindowRecharge.WindowWidth) / 2;
         this.FUIWindowRecharge.y = (CONST_COMMON.STAGE_Height - this.FUIWindowRecharge.WindowHeight) / 2;
         TUtilityUIWindow.SetupWindowRecharge(this.FUIWindowRecharge);
         super.ResourcesPerform_UIRequest();
      }
      
      override protected function ResourcesPerform_UIDispatch() : void
      {
         this.FMC = TUtilityReflection.CreateDisplayObjectInstance(CONST_COPYCLASSROOM.RESOURCE_ClassName_MC_PopupBuy) as Sprite;
         this.addChild(this.FMC);
         this.FBtn_Ok = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_Btn_Ok];
         this.FBtn_Close = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_Btn_Close];
         this.FTF_CostGold = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_TF_CostGold];
         this.FTF_BuyTimesPrompt = this.FMC[CONST_COPYCLASSROOM.RESOURCE_Link_TF_CanBuyCount];
         this.FBtn_Ok.buttonMode = true;
         this.FBtn_Close.buttonMode = true;
         this.FVipConfigBin = SResourcesCore.ResourceBin.GetBinsByResourceID(CONST_DATEBASEVO.RESOURCEID_VipConfig);
         this.FConfigValue = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_ConfigValue,CONST_CONFIGVALUE.CopyHero_ChangeHeroBuyGold) as TConfigValue;
         this.FCostGold = this.FConfigValue.Value as Vector.<uint>;
         super.ResourcesPerform_UIDispatch();
      }
      
      override protected function ResourcesPerform_UILocations() : void
      {
         this.FBtn_Ok.addEventListener(MouseEvent.CLICK,this.OnCopyingBuyClick);
         this.FBtn_Close.addEventListener(MouseEvent.CLICK,FOnClose);
         super.ResourcesPerform_UILocations();
      }
      
      override protected function LogicsPerform() : void
      {
         super.LogicsPerform();
      }
      
      protected function OnCopyingBuyClick(param1:MouseEvent) : void
      {
         var _loc3_:TPacket = null;
         if(this.FTotalCanBuyCount - this.FAlreadyBuyCount <= 0)
         {
            return;
         }
         var _loc2_:TCharacter = SLogicsCore.Character;
         if(this.FCostGold[this.FAlreadyBuyCount] > _loc2_.CreditGold + _loc2_.CreditGiftCertificate)
         {
            this.FUIWindowRecharge.Visible = true;
            return;
         }
         FOnClose(this);
         _loc3_ = SNetworkCore.PacketAcquire(CONST_NETWORK.PACKETID_CS_CopyHero_BuyCopyTimesReq);
         SNetworkCore.Transceiver.PacketTransmit(_loc3_);
      }
      
      protected function UpdateTF() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:TVipConfig = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         this.FTotalCanBuyCount = SLogicsCore.Character.VipData.ChangeBuyNum;
         _loc1_ = this.FTotalCanBuyCount - this.FAlreadyBuyCount;
         _loc2_ = SLogicsCore.Character.VipData.VipLevel < SLogicsCore.Character.VipData.VipLevelUpperLimit ? int(SLogicsCore.Character.VipData.VipLevel + 1) : int(SLogicsCore.Character.VipData.VipLevel);
         _loc3_ = int(SLogicsCore.Character.VipData.VipLevel);
         _loc7_ = SLogicsCore.Character.VipData.VipLevelUpperLimit + 1;
         _loc4_ = 0;
         if(_loc3_ < SLogicsCore.Character.VipData.VipLevelUpperLimit)
         {
            _loc6_ = _loc3_;
            while(_loc6_ < _loc7_)
            {
               _loc5_ = this.FVipConfigBin.GetDatebaseByIdentifier(_loc6_) as TVipConfig;
               if(_loc5_.ChangeBuyNum > this.FTotalCanBuyCount)
               {
                  _loc4_ = _loc5_.ChangeBuyNum;
                  _loc2_ = _loc6_;
                  break;
               }
               _loc6_++;
            }
         }
         if(_loc5_ != null)
         {
            _loc4_ = _loc5_.ChangeBuyNum;
         }
         if(_loc4_ == 0 || _loc3_ == SLogicsCore.Character.VipData.VipLevelUpperLimit)
         {
            this.FTF_BuyTimesPrompt.text = TUtilityString.Format(STRING_COPYCLASSROOM.FORMAT_BuyCountWithoutMoreVip,_loc1_);
         }
         else
         {
            this.FTF_BuyTimesPrompt.text = TUtilityString.Format(STRING_COPYCLASSROOM.FORMAT_BuyCount,_loc1_,_loc2_,_loc4_);
         }
         this.FTF_CostGold.text = String(this.FCostGold[this.FAlreadyBuyCount]);
      }
      
      protected function UpdateBtn() : void
      {
         TGameUtil.LockOrUnlockButton(this.FBtn_Ok,Boolean(this.FTotalCanBuyCount - this.FAlreadyBuyCount > 0));
      }
      
      public function get AlreadyBuyCount() : uint
      {
         return this.FAlreadyBuyCount;
      }
      
      public function set AlreadyBuyCount(param1:uint) : void
      {
         this.FAlreadyBuyCount = param1;
      }
      
      public function UpDateUI() : void
      {
         this.UpdateTF();
         this.UpdateBtn();
      }
   }
}


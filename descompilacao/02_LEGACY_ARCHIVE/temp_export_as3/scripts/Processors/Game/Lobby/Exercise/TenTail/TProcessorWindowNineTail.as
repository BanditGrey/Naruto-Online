package Processors.Game.Lobby.Exercise.TenTail
{
   import Foundation.Timing.STimingCore;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityDate;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.FrogWallet.TTenTail;
   import Logics.SLogicsCore;
   import Processors.Game.Lobby.Common.TProcessorLobbyWindow;
   import Resources.Constants.CONST_TENTAIL;
   import Resources.Strings.STRING_FROGWALLET;
   import flash.display.MovieClip;
   import flash.text.TextField;
   
   public class TProcessorWindowNineTail extends TProcessorLobbyWindow
   {
      
      public static const SOUL_COUNT:int = 9;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FInitialized:Boolean;
      
      protected var FTenTail:TTenTail;
      
      protected var FSoulList:Vector.<MovieClip>;
      
      protected var FTF_Time:TextField;
      
      protected var FTF_Date:TextField;
      
      protected var FTF_Desc1:TextField;
      
      protected var FTF_Desc2:TextField;
      
      protected var FTF_Desc3:TextField;
      
      protected var FTF_Desc4:TextField;
      
      public function TProcessorWindowNineTail(param1:TUIComponent)
      {
         super(param1);
         this.FTenTail = SLogicsCore.TenTail;
         this.FSoulList = new Vector.<MovieClip>(SOUL_COUNT);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:MovieClip = null;
         this.FMC_Scene = param1;
         addChild(this.FMC_Scene);
         _loc2_ = 0;
         while(_loc2_ < SOUL_COUNT)
         {
            _loc4_ = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_MC_Soul + _loc2_];
            this.FSoulList[_loc2_] = _loc4_;
            _loc2_++;
         }
         this.FTF_Date = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_DATE];
         this.FTF_Desc1 = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_Desc + "1"];
         this.FTF_Desc2 = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_Desc + "2"];
         this.FTF_Desc3 = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_Desc + "3"];
         this.FTF_Desc4 = this.FMC_Scene[CONST_TENTAIL.RESOURCE_LINK_TF_Desc + "4"];
      }
      
      protected function UpdateText() : void
      {
         this.FTF_Date.text = TUtilityString.Format(STRING_FROGWALLET.FormatString_TimeStartToEnd,TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FTenTail.BeginTime) * 1000)),TUtilityDate.FormatDateChineseNew(new Date(STimingCore.GetClientShowTime(this.FTenTail.PayEndTime - 1) * 1000)));
         this.FTF_Desc1.htmlText = this.FTenTail.ActivityDesc;
         this.FTF_Desc2.text = this.FTenTail.GetNextSoulDesc();
         this.FTF_Desc3.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_TODAY_SOUL,this.FTenTail.CurSoul);
         this.FTF_Desc4.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_EXCHANGE_SCALE,this.FTenTail.ExchangeScale);
      }
      
      protected function UpdateSoul() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:int = this.FTenTail.GetCurSoulIndex();
         _loc1_ = 0;
         while(_loc1_ < SOUL_COUNT)
         {
            _loc3_ = this.FSoulList[_loc1_];
            if(_loc1_ < _loc4_)
            {
               _loc3_.gotoAndStop(2);
            }
            else
            {
               _loc3_.gotoAndStop(1);
            }
            _loc3_.MC_Soul.gotoAndStop(_loc1_ + 1);
            _loc3_.TF_Soul.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_SOUL,this.FTenTail.DisplaySoulConfig[_loc1_]);
            _loc3_.TF_Certificate.text = TUtilityString.Format(STRING_FROGWALLET.FORMAT_CERTIFICATE,this.FTenTail.CertificateConfig[_loc1_]);
            _loc1_++;
         }
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function UpdateUI() : void
      {
         this.UpdateText();
         this.UpdateSoul();
      }
   }
}


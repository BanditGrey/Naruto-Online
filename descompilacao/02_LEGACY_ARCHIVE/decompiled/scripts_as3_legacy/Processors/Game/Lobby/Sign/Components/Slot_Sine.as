package Processors.Game.Lobby.Sign.Components
{
   import Foundation.Resources.Bins.TBins;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityString;
   import Logics.DailySign.TDailySign;
   import Logics.DatebaseVO.VO.TSignContinuous;
   import Logics.Inventories.TInventories;
   import Logics.Streamization.Inventories.TUnstreamizerInventoryReference;
   import Resources.Constants.CONST_MODULES;
   import Resources.Strings.STRING_DAILYSIGN;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class Slot_Sine
   {
      
      protected var FBit:Bitmap = null;
      
      protected var FThisPanel:MovieClip = null;
      
      protected var FMHuiYe:MovieClip = null;
      
      protected var FMVip:MovieClip = null;
      
      protected var FMC_GetBtn:MovieClip = null;
      
      protected var FMC_Slot:MovieClip = null;
      
      protected var FMC_Bmp_Icon:MovieClip = null;
      
      protected var FTF_Integral:TextField = null;
      
      protected var FMC_Bmp_IconHighLight:MovieClip = null;
      
      protected var FTF_SignDay:TextField = null;
      
      protected var FSign:TSignContinuous = null;
      
      protected var FCurDay:int;
      
      protected var FIDTemplates:Vector.<uint>;
      
      protected var FInventories:TInventories;
      
      protected var FUnstreamizerInventoryReference:TUnstreamizerInventoryReference;
      
      protected var FDateSine:TDailySign = null;
      
      protected var FGodCount:int;
      
      protected var FIsCanClick:Boolean;
      
      protected var FBackFun:Function = null;
      
      protected var FFBackmoveFun:Function = null;
      
      protected var FFBackoutFun:Function = null;
      
      protected var FCurConfigBin:TBins;
      
      protected var CurIndex:int;
      
      protected var CurIndexCopy:int;
      
      public function Slot_Sine(param1:MovieClip)
      {
         super();
         this.FBit = new Bitmap();
         this.FThisPanel = param1;
         this.FMC_Bmp_IconHighLight = this.FThisPanel["MC_Slot"]["MC_Bmp_IconHighLight"];
         if(this.FMC_Bmp_IconHighLight)
         {
            this.FMC_Bmp_IconHighLight.visible = false;
         }
         this.FIDTemplates = new Vector.<uint>();
         this.FInventories = new TInventories();
         this.FUnstreamizerInventoryReference = new TUnstreamizerInventoryReference();
         this.FThisPanel.addEventListener(MouseEvent.CLICK,this.ThisPanelClick);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OVER,this.ThisPanelOver);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_OUT,this.ThisPanelOut);
         this.FThisPanel.addEventListener(MouseEvent.MOUSE_MOVE,this.ThisPanelMove);
      }
      
      protected function ThisPanelOver(param1:MouseEvent) : void
      {
         if(this.FThisPanel.currentFrame == 2)
         {
            this.FThisPanel.buttonMode = true;
         }
         else
         {
            this.FThisPanel.buttonMode = false;
         }
         if(this.FMC_Bmp_IconHighLight)
         {
            this.FMC_Bmp_IconHighLight.visible = true;
         }
      }
      
      protected function ThisPanelOut(param1:MouseEvent) : void
      {
         if(this.FThisPanel.currentFrame == 2)
         {
            this.FThisPanel.buttonMode = false;
         }
         if(this.FMC_Bmp_IconHighLight)
         {
            this.FMC_Bmp_IconHighLight.visible = false;
         }
         if(this.FInventories.Count == 0)
         {
            return;
         }
         if(this.FFBackoutFun != null)
         {
            this.FFBackoutFun(null,this.FInventories.GetInventoryByIndex(this.FInventories.Count - 1));
         }
      }
      
      protected function ThisPanelMove(param1:MouseEvent) : void
      {
         if(this.FInventories.Count == 0)
         {
            return;
         }
         if(this.FFBackmoveFun != null)
         {
            this.FFBackmoveFun(null,this.FInventories.GetInventoryByIndex(this.FInventories.Count - 1));
         }
      }
      
      protected function ThisPanelClick(param1:MouseEvent) : void
      {
         if(this.FThisPanel.currentFrame != 2)
         {
            return;
         }
         if(this.FBackFun != null)
         {
            this.FBackFun(this.FSign.Identifier);
         }
      }
      
      public function UpdatePanel() : void
      {
         this.FMHuiYe = this.FThisPanel["MC_HuiYeTeQuan"];
         if(this.FMHuiYe)
         {
            this.FMHuiYe.buttonMode = false;
            this.FMHuiYe.mouseEnabled = false;
         }
         this.FMVip = this.FThisPanel["MC_VipTeQuan"];
         if(this.FMVip)
         {
            this.FMVip.buttonMode = false;
            this.FMVip.mouseEnabled = false;
         }
         this.FMC_GetBtn = this.FThisPanel["MC_GetBtn"];
         this.FMC_Slot = this.FThisPanel["MC_Slot"];
         if(this.FMC_Slot)
         {
            this.FMC_Bmp_Icon = this.FMC_Slot["MC_Bmp_Icon"];
            this.FTF_Integral = this.FMC_Slot["TF_Integral"];
            if(this.FTF_Integral)
            {
               this.FTF_Integral.mouseEnabled = false;
            }
         }
         this.FTF_SignDay = this.FThisPanel["TF_SignDay"];
         if(this.FMC_Bmp_Icon)
         {
            this.FMC_Bmp_Icon.addChild(this.FBit);
         }
      }
      
      public function SetDate(param1:TSignContinuous, param2:int, param3:TBins) : void
      {
         var _loc4_:int = 0;
         this.FSign = param1;
         this.FCurDay = param2;
         this.FCurConfigBin = param3;
         if(this.FSign)
         {
            this.FThisPanel.gotoAndStop(1);
            this.UpdatePanel();
            this.FInventories.Clear();
            this.FIDTemplates.length = 0;
            this.FGodCount = 0;
            if(this.FSign.QianDaoRewardsVect.length != 0)
            {
               _loc4_ = 0;
               while(_loc4_ < this.FSign.QianDaoRewardsVect.length)
               {
                  this.FIDTemplates.push(this.FSign.QianDaoRewardsVect[_loc4_].Code);
                  this.FGodCount += this.FSign.QianDaoRewardsVect[_loc4_].Amount;
                  _loc4_++;
               }
            }
            if(this.FSign.TabooRewardsVect.length == 0)
            {
               _loc4_ = 0;
               while(_loc4_ < this.FSign.TabooRewardsVect.length)
               {
                  this.FIDTemplates.push(this.FSign.TabooRewardsVect[_loc4_].Code);
                  _loc4_++;
               }
            }
            if(this.FSign.VipRewardsVect.length == 0)
            {
               _loc4_ = 0;
               while(_loc4_ < this.FSign.VipRewardsVect.length)
               {
                  this.FIDTemplates.push(this.FSign.VipRewardsVect[_loc4_].Code);
                  _loc4_++;
               }
            }
            this.FUnstreamizerInventoryReference.UnstreamizeGenerateInventoriesByIdentifiers(null,this.FInventories,this.FIDTemplates);
         }
         else
         {
            this.FThisPanel.gotoAndStop(4);
            this.UpdatePanel();
         }
         this.reshCao();
      }
      
      protected function ReturnBoolearn(param1:TSignContinuous) : Boolean
      {
         return param1.QianDaoRewardsVect.length == 0 && param1.VipRewardsVect.length == 0 && param1.TabooRewardsVect.length == 0;
      }
      
      protected function ReturnIndex(param1:uint) : void
      {
         var _loc2_:TSignContinuous = null;
         var _loc3_:uint = param1;
         _loc2_ = this.FCurConfigBin.GetDatebaseByIdentifier(param1 + 1) as TSignContinuous;
         if(!_loc2_)
         {
            return;
         }
         if(this.ReturnBoolearn(_loc2_))
         {
            ++this.CurIndex;
            _loc3_++;
            this.ReturnIndex(_loc3_);
            return;
         }
      }
      
      protected function ReturnBoolearnA(param1:int) : Boolean
      {
         var _loc2_:TSignContinuous = null;
         var _loc3_:int = param1;
         _loc2_ = this.FCurConfigBin.GetDatebaseByIdentifier(_loc3_ - 1) as TSignContinuous;
         if(_loc2_)
         {
            if(this.ReturnBoolearn(_loc2_))
            {
               if(_loc2_.Day == 1)
               {
                  return true;
               }
               _loc3_--;
               this.ReturnBoolearnA(_loc3_);
            }
         }
         return false;
      }
      
      public function UpdateStateById(param1:int, param2:Boolean) : void
      {
         this.FIsCanClick = false;
         if(!this.FSign)
         {
            return;
         }
         if(param1 == 0)
         {
            if(this.ReturnBoolearn(this.FSign))
            {
               this.FThisPanel.gotoAndStop(4);
            }
            else if(this.FDateSine.SignTotalDaysCopy > 1)
            {
               if(this.FCurDay == 1 || this.ReturnBoolearnA(this.FSign.Identifier))
               {
                  this.FThisPanel.gotoAndStop(2);
                  this.FIsCanClick = true;
               }
               else
               {
                  this.FThisPanel.gotoAndStop(1);
               }
            }
            else if(this.FCurDay == 1 && this.FDateSine.SignTotalDaysCopy > 0)
            {
               this.FThisPanel.gotoAndStop(2);
               this.FIsCanClick = true;
            }
            else
            {
               this.FThisPanel.gotoAndStop(1);
            }
         }
         else if(this.ReturnBoolearn(this.FSign))
         {
            this.FThisPanel.gotoAndStop(4);
         }
         else if(param2)
         {
            this.CurIndex = 1;
            this.ReturnIndex(param1);
            if(this.FSign.Day <= this.FDateSine.SignTotalDaysCopy && this.FSign.Identifier == param1 + this.CurIndex)
            {
               this.FThisPanel.gotoAndStop(2);
               this.FIsCanClick = true;
            }
            else if(this.FSign.Identifier <= param1)
            {
               this.FThisPanel.gotoAndStop(3);
            }
            else
            {
               this.FThisPanel.gotoAndStop(1);
            }
         }
         else if(this.FSign.Identifier <= param1)
         {
            this.FThisPanel.gotoAndStop(3);
         }
         else
         {
            this.FThisPanel.gotoAndStop(1);
         }
         this.UpdatePanel();
         this.reshCao();
      }
      
      public function reshCao() : void
      {
         if(this.FTF_Integral)
         {
            this.FTF_Integral.visible = false;
         }
         if(this.FSign)
         {
            if(this.ReturnBoolearn(this.FSign))
            {
               if(this.FTF_SignDay)
               {
                  this.FTF_SignDay.text = TUtilityString.Format(STRING_DAILYSIGN.STRING_DayDec,this.FCurDay);
               }
            }
            else
            {
               if(this.FTF_Integral)
               {
                  this.FTF_Integral.visible = true;
                  this.FTF_Integral.text = this.FGodCount.toString();
               }
               if(this.FSign.VipCondition == 0)
               {
                  if(this.FMVip)
                  {
                     this.FMVip.visible = false;
                  }
               }
               else if(this.FMVip)
               {
                  this.FMVip.visible = true;
                  TextField(this.FMVip["TF_Dec"]).text = TUtilityString.Format(STRING_DAILYSIGN.STRING_VipDec,this.FSign.VipCondition);
               }
               if(this.FSign.NightPowerCondition == 0)
               {
                  if(this.FMHuiYe)
                  {
                     this.FMHuiYe.visible = false;
                  }
               }
               else if(this.FMHuiYe)
               {
                  this.FMHuiYe.visible = true;
                  TextField(this.FMHuiYe["TF_Dec"]).text = TUtilityString.Format(STRING_DAILYSIGN.STRING_HuiYeDec,this.FSign.NightPowerCondition);
               }
            }
         }
         else if(this.FTF_SignDay)
         {
            this.FTF_SignDay.text = TUtilityString.Format(STRING_DAILYSIGN.STRING_DayDec,this.FCurDay);
         }
      }
      
      public function UpdateImage() : void
      {
         if(!this.FSign)
         {
            return;
         }
         if(this.FThisPanel.currentFrame == 4)
         {
            return;
         }
         if(this.FInventories.Count == 0)
         {
            return;
         }
         TGameUtil.ShowImageByID(TGameUtil.Type_Inventory,this.FBit,CONST_MODULES.MODULE_Sign,this.FInventories.GetInventoryByIndex(0).IDTexture);
      }
      
      public function get Ftories() : TInventories
      {
         return this.FInventories;
      }
      
      public function get SignB() : TSignContinuous
      {
         return this.FSign;
      }
      
      public function set BackFun(param1:Function) : void
      {
         this.FBackFun = param1;
      }
      
      public function set FBackmoveFun(param1:Function) : void
      {
         this.FFBackmoveFun = param1;
      }
      
      public function set FBackoutFun(param1:Function) : void
      {
         this.FFBackoutFun = param1;
      }
      
      public function set DateSine(param1:TDailySign) : void
      {
         this.FDateSine = param1;
      }
      
      public function get IsCanClick() : Boolean
      {
         return this.FIsCanClick;
      }
   }
}


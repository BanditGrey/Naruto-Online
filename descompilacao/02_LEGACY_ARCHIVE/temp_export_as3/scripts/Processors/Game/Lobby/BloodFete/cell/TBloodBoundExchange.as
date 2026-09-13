package Processors.Game.Lobby.BloodFete.cell
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TGameUtil;
   import Foundation.Utilities.TUtilityReflection;
   import Logics.DatebaseVO.VO.TFollowBloodBound;
   import Logics.DatebaseVO.VO.TFollowBloodBoundExchange;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_BLOODFETE;
   import Resources.Constants.CONST_COMMON;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_COMMON;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class TBloodBoundExchange extends Sprite
   {
      
      protected var ThisPanel:MovieClip;
      
      protected var TF_OrgName:TextField;
      
      protected var TF_OrgMasterName:TextField;
      
      protected var FTF_CostCellCount:TextField;
      
      protected var FMc_1:MovieClip = null;
      
      protected var FMc_2:MovieClip = null;
      
      protected var BTN_ApplyOrg:MovieClip;
      
      protected var IsCanClcik:Boolean;
      
      protected var DateCell:TFollowBloodBoundExchange;
      
      protected var FFollowBloodBound:TFollowBloodBound = null;
      
      protected var FBackFunction:Function;
      
      protected var FMoMo:Function;
      
      protected var FOvMo:Function;
      
      public function TBloodBoundExchange(param1:TFollowBloodBoundExchange)
      {
         super();
         this.DateCell = param1;
         this.LoadFla();
         this.UpdateData();
      }
      
      protected function LoadFla() : void
      {
         this.ThisPanel = TUtilityReflection.CreateDisplayObjectInstance(CONST_BLOODFETE.MC_BloodFete_Cell_Bar) as MovieClip;
         this.addChild(this.ThisPanel);
         this.addEventListener(MouseEvent.MOUSE_MOVE,this.MouseMove);
         this.addEventListener(MouseEvent.MOUSE_OUT,this.OverMove);
         this.TF_OrgName = this.ThisPanel["MC_RT"]["TF_OrgName"];
         this.TF_OrgMasterName = this.ThisPanel["MC_RT"]["TF_OrgMasterName"];
         this.FTF_CostCellCount = this.ThisPanel["MC_RT"]["TF_CostCellCount"];
         this.BTN_ApplyOrg = this.ThisPanel["MC_RT"]["BTN_ApplyOrg"];
         this.FMc_2 = this.ThisPanel["MC_RT"]["MC_BeijingTwo"];
         this.FMc_1 = this.ThisPanel["MC_RT"]["MC_BeijingOne"];
         this.BTN_ApplyOrg.addEventListener(MouseEvent.CLICK,this.BackClcik);
      }
      
      protected function UpdateData() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:String = "";
         this.FFollowBloodBound = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_FollowBloodBound,this.DateCell.PurgatoryID) as TFollowBloodBound;
         this.TF_OrgName.text = this.FFollowBloodBound.Name;
         this.TF_OrgName.textColor = CONST_COMMON.QUALITYCOLOR_INDEX[this.FFollowBloodBound.Quality];
         if(this.FFollowBloodBound.AddAttrArr)
         {
            _loc3_ = 0;
            while(_loc3_ < this.FFollowBloodBound.AddAttrArr.length)
            {
               _loc2_ = this.FFollowBloodBound.AddAttrArr[_loc3_];
               _loc1_ += STRING_COMMON.STRINGS_BASEATTRIBUTENAMES[CONST_COMMON.BASEATTRIBUTENAMES.indexOf(_loc2_[0])] + "  +";
               if(int(_loc2_[1]) != _loc2_[1])
               {
                  _loc1_ += Number(_loc2_[1] * 100).toFixed(1) + "%";
               }
               else
               {
                  _loc1_ += _loc2_[1];
               }
               if(this.FFollowBloodBound.AddAttrArr.length > 1 && _loc3_ < this.FFollowBloodBound.AddAttrArr.length - 1)
               {
                  _loc1_ += ",";
               }
               _loc3_++;
            }
         }
         this.TF_OrgMasterName.text = _loc1_;
         this.UpdateIsCanClick();
         if(this.DateCell.IsExchange == 1)
         {
            this.filters = [];
            this.IsCanClcik = true;
         }
         else
         {
            this.filters = [TGameUtil.darkFilters];
            this.IsCanClcik = false;
         }
         this.FTF_CostCellCount.text = this.DateCell.Cost.toString();
      }
      
      public function MouseMove(param1:MouseEvent) : void
      {
         if(this.FMoMo != null)
         {
            this.FMoMo(this.DateCell);
         }
      }
      
      public function OverMove(param1:MouseEvent) : void
      {
         if(this.FOvMo != null)
         {
            this.FOvMo(this.DateCell);
         }
      }
      
      protected function BackClcik(param1:MouseEvent) : void
      {
         if(this.IsCanClcik)
         {
            if(this.FBackFunction != null)
            {
               this.FBackFunction(this.DateCell.PurgatoryID);
            }
         }
      }
      
      public function set MoMo(param1:Function) : void
      {
         this.FMoMo = param1;
      }
      
      public function get MoMo() : Function
      {
         return this.FMoMo;
      }
      
      public function set OvMo(param1:Function) : void
      {
         this.FOvMo = param1;
      }
      
      public function get OvMo() : Function
      {
         return this.FOvMo;
      }
      
      public function set BackFunction(param1:Function) : void
      {
         this.FBackFunction = param1;
      }
      
      public function setIndex(param1:int) : void
      {
         this.FMc_2.visible = false;
         this.FMc_1.visible = false;
         if(param1)
         {
            this.FMc_2.visible = true;
         }
         else
         {
            this.FMc_1.visible = true;
         }
      }
      
      public function UpdateIsCanClick() : void
      {
         if(SLogicsCore.BloodFeteDatas.DebrisNum >= this.DateCell.Cost)
         {
            TGameUtil.setButtonMode(this.BTN_ApplyOrg,true);
            this.IsCanClcik = true;
         }
         else
         {
            TGameUtil.setButtonMode(this.BTN_ApplyOrg,false);
            this.IsCanClcik = false;
         }
      }
   }
}


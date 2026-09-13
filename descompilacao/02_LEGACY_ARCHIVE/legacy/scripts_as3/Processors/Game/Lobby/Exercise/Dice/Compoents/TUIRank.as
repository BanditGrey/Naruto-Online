package Processors.Game.Lobby.Exercise.Dice.Compoents
{
   import Components.Pages.TUIPage;
   import Foundation.UI.TUIComponent;
   import Foundation.Utilities.TUtilityString;
   import Logics.Exercise.Dice.TDice;
   import Logics.SLogicsCore;
   import Resources.Constants.CONST_DICE;
   import Resources.Strings.STRING_DICE;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class TUIRank extends TUIComponent
   {
      
      protected static const MAX_COUNT:int = 10;
      
      protected var FMC_Scene:MovieClip;
      
      protected var FUIPage:TUIPage;
      
      protected var FMC_ChangePage:MovieClip;
      
      protected var FUI_Left_Btn:MovieClip;
      
      protected var FUI_Right_Btn:MovieClip;
      
      protected var FTF_Page:TextField;
      
      protected var FTotalPage:int = 5;
      
      protected var FCurPage:int;
      
      protected var FDice:TDice;
      
      protected var FRankList:Vector.<Sprite>;
      
      protected var FFORMAT_NAME:TextFormat;
      
      protected var FInitialized:Boolean;
      
      protected var FOnNameUp:Function;
      
      public function TUIRank(param1:TUIComponent)
      {
         super(param1);
         this.FUIPage = new TUIPage(this);
         this.FRankList = new Vector.<Sprite>(MAX_COUNT);
      }
      
      protected function Resources_UIDispatch(param1:MovieClip) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Sprite = null;
         this.FMC_Scene = param1;
         _loc2_ = 0;
         while(_loc2_ < MAX_COUNT)
         {
            _loc4_ = this.FMC_Scene["MC_Rank" + _loc2_];
            _loc4_.buttonMode = true;
            _loc4_.mouseChildren = false;
            _loc4_.addEventListener(MouseEvent.MOUSE_UP,this.ProcessorOnNameUp,false,0,true);
            this.FRankList[_loc2_] = _loc4_;
            _loc2_++;
         }
         if(this.FFORMAT_NAME == null)
         {
            this.FFORMAT_NAME = new TextFormat();
            this.FFORMAT_NAME.underline = true;
         }
         this.ResourcesPerform_UIDispatchChangePage();
      }
      
      protected function ResourcesPerform_UIDispatchChangePage() : void
      {
         this.FMC_ChangePage = this.FMC_Scene[CONST_DICE.RESOURCE_Link_MC_ChangePage];
         this.FUI_Left_Btn = this.FMC_ChangePage["MC_PageLeft"];
         this.FUI_Right_Btn = this.FMC_ChangePage["MC_PageRight"];
         this.FTF_Page = this.FMC_ChangePage["TF_Page"];
         this.FUIPage.ButtonPrevious.Substrate = this.FUI_Left_Btn;
         this.FUIPage.ButtonNext.Substrate = this.FUI_Right_Btn;
         this.FUIPage.LabelPage = this.FTF_Page;
         this.FUIPage.TotalQuantity = this.FTotalPage;
         this.FUIPage.PageSize = MAX_COUNT;
         this.FUIPage.PageIndex = 0;
         this.FCurPage = 0;
         this.FUIPage.OnChangePage = this.ProcessorPageOnChange;
      }
      
      protected function UpdateRank() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         var _loc4_:TextField = null;
         var _loc5_:TextField = null;
         this.FUIPage.TotalQuantity = this.FDice.RankList.length;
         this.FUIPage.Update();
         _loc1_ = 0;
         while(_loc1_ < MAX_COUNT)
         {
            _loc2_ = _loc1_ + this.FCurPage * MAX_COUNT;
            _loc3_ = this.FMC_Scene[CONST_DICE.RESOURCE_Link_MC_Rank + _loc1_];
            _loc4_ = _loc3_.TF_Name;
            _loc5_ = _loc3_.TF_Count;
            if(_loc2_ < this.FDice.RankList.length)
            {
               if(this.FCurPage == 0)
               {
                  this.FMC_Scene.MC_Floor.visible = true;
                  this.FMC_Scene.TF_FirstNum.visible = true;
                  this.FMC_Scene.TF_SecondNum.visible = true;
                  this.FMC_Scene.TF_ThirdNum.visible = true;
               }
               else
               {
                  this.FMC_Scene.MC_Floor.visible = false;
                  this.FMC_Scene.TF_FirstNum.visible = false;
                  this.FMC_Scene.TF_SecondNum.visible = false;
                  this.FMC_Scene.TF_ThirdNum.visible = false;
               }
               _loc4_.visible = true;
               if(_loc2_ < 3)
               {
                  _loc4_.text = TUtilityString.Format(STRING_DICE.FORMAT_RankNameNonePoint,this.FDice.RankList[_loc2_].Name);
               }
               else
               {
                  _loc4_.text = TUtilityString.Format(STRING_DICE.FORMAT_RankName,_loc2_ + 1,this.FDice.RankList[_loc2_].Name);
               }
               _loc4_.setTextFormat(this.FFORMAT_NAME);
               _loc5_.visible = true;
               _loc5_.text = this.FDice.RankList[_loc2_].WinCount.toString();
            }
            else
            {
               _loc4_.visible = false;
               _loc5_.visible = false;
            }
            _loc1_++;
         }
      }
      
      protected function ProcessorPageOnChange(param1:Object, param2:int) : void
      {
         this.FCurPage = param2;
         this.UpdateUI();
      }
      
      protected function ProcessorOnNameUp(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = int(String(param1.currentTarget.name).slice(7));
         _loc3_ = _loc2_ + this.FCurPage * MAX_COUNT;
         if(this.FOnNameUp != null)
         {
            this.FOnNameUp(this.FDice.RankList[_loc3_].Identifier0,this.FDice.RankList[_loc3_].Identifier1);
         }
      }
      
      public function get OnNameUp() : Function
      {
         return this.FOnNameUp;
      }
      
      public function set OnNameUp(param1:Function) : void
      {
         this.FOnNameUp = param1;
      }
      
      public function Perform_UIDispatch(param1:MovieClip) : void
      {
         this.Resources_UIDispatch(param1);
         this.FInitialized = true;
      }
      
      public function LogicsPerform() : void
      {
         if(this.FInitialized && this.visible)
         {
         }
      }
      
      public function UpdateUI() : void
      {
         this.FDice = SLogicsCore.Dice;
         this.UpdateRank();
      }
   }
}


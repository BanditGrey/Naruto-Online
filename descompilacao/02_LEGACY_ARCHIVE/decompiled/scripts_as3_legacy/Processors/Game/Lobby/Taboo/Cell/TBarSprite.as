package Processors.Game.Lobby.Taboo.Cell
{
   import Foundation.Resources.SResourcesCore;
   import Foundation.Utilities.TUtilityString;
   import Logics.DatebaseVO.VO.TArticle;
   import Logics.DatebaseVO.VO.TTabooAddition;
   import Logics.DatebaseVO.VO.TTabooBattle;
   import Logics.DatebaseVO.VO.TTabooBattleConfig;
   import Logics.DatebaseVO.VO.TTabooConfig;
   import Resources.Constants.CONST_DATEBASEVO;
   import Resources.Strings.STRING_TABOO;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   
   public class TBarSprite extends Sprite
   {
      
      protected var CurTextField:TextField = null;
      
      protected var TbConfig:TTabooConfig = null;
      
      protected var Tbaddtion:TTabooAddition = null;
      
      protected var TbooBattle:TTabooBattle = null;
      
      protected var TbooBattleConfig:TTabooBattleConfig = null;
      
      protected var Tartial:TArticle = null;
      
      protected var str:String;
      
      public function TBarSprite()
      {
         super();
         this.CurTextField = new TextField();
         this.CurTextField.width = 350;
         this.CurTextField.height = 20;
         this.CurTextField.textColor = 16777215;
         this.CurTextField.autoSize = TextFieldAutoSize.LEFT;
         this.CurTextField.wordWrap = false;
         addChild(this.CurTextField);
      }
      
      public function SetName(param1:uint, param2:uint, param3:uint, param4:uint) : void
      {
         this.str = "";
         if(param2 == 18)
         {
            this.TbConfig = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooConfig,param3) as TTabooConfig;
            this.str = TUtilityString.Format(STRING_TABOO.Str19,this.TbConfig.Name,param4);
         }
         else
         {
            this.Tartial = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_Article,param3) as TArticle;
            this.str = TUtilityString.Format(STRING_TABOO.Str19,this.Tartial.Name,param4);
         }
         this.TbConfig = null;
         this.Tartial = null;
         this.UpdateView();
      }
      
      public function SetNameCopy(param1:uint) : void
      {
         this.str = "";
         this.TbooBattle = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooBattle,param1) as TTabooBattle;
         this.TbooBattleConfig = SResourcesCore.ResourceBin.GetDatebase(CONST_DATEBASEVO.RESOURCEID_TabooBattleConfig,this.TbooBattle.Location) as TTabooBattleConfig;
         this.str = TUtilityString.Format(STRING_TABOO.Str18,this.TbooBattleConfig.CampaignName,this.TbooBattle.Name);
         this.TbooBattle = null;
         this.TbooBattleConfig = null;
         this.UpdateView();
      }
      
      public function DreawLine() : void
      {
         this.str = "";
         this.str = STRING_TABOO.Str20;
         this.UpdateView();
      }
      
      public function DreawLine7() : void
      {
         this.str = "";
         this.str = STRING_TABOO.Str26;
         this.UpdateView();
      }
      
      protected function UpdateView() : void
      {
         this.CurTextField.text = this.str;
      }
   }
}

